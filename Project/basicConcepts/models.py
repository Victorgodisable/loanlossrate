from django.db import models
from jsonfield import JSONField
from django.conf import settings
from django.utils import timezone
class Reason(models.Model):
    name = models.CharField(max_length=255, unique=True)

    def __str__(self):
        return self.name    
class ProductDetail(models.Model):
    loan_id = models.CharField(max_length=5000)  # Add this field
    payment_plan = models.CharField(max_length=5000)
    cost_per_credit = models.DecimalField(max_digits=65, decimal_places=2)
    deposit = models.DecimalField(max_digits=65, decimal_places=2)
    loan_duration = models.IntegerField()
    product_price = models.DecimalField(max_digits=65, decimal_places=2)
    product_price_weighted_llr_200 = models.DecimalField(max_digits=15, decimal_places=4)
    quality_of_sales = models.CharField(max_length=5000)
    deposit_to_price_ratio = models.DecimalField(max_digits=65, decimal_places=4)

    def __str__(self):
        return self.payment_plan

class LLRPricingAssumption(models.Model):
    payment_plan = models.ForeignKey(ProductDetail, related_name='llr_assumptions', on_delete=models.CASCADE)
    instance_number = models.IntegerField(null=True, blank=True)
    cost_per_credit = models.DecimalField(max_digits=65, decimal_places=2)
    loan_duration = models.IntegerField()
    deposit = models.DecimalField(max_digits=65, decimal_places=2)
    price = models.DecimalField(max_digits=65, decimal_places=2)
    deposit_to_price_ratio = models.DecimalField(max_digits=65, decimal_places=4)
    predicted_llr = models.DecimalField(max_digits=15, decimal_places=2)

    anticipated_growth = models.DecimalField(max_digits=5, decimal_places=2 ,null=True, blank=True)
    price_change = models.DecimalField(max_digits=5, decimal_places=2,null=True, blank=True)
    total_volume_before = models.IntegerField(null=True, blank=True)
    total_volume_after = models.IntegerField(null=True, blank=True)
    unit_price_before = models.DecimalField(max_digits=10, decimal_places=2,null=True, blank=True)
    unit_price_after = models.DecimalField(max_digits=10, decimal_places=2,null=True, blank=True)
    gross_revenue_before = models.DecimalField(max_digits=15, decimal_places=2,null=True, blank=True)
    gross_revenue_after = models.DecimalField(max_digits=15, decimal_places=2,null=True, blank=True)
    current_priced_cm2_before = models.DecimalField(max_digits=5, decimal_places=2,null=True, blank=True)
    current_priced_cm2_after = models.DecimalField(max_digits=5, decimal_places=2,null=True, blank=True)
    expected_cm2_revenue_before = models.DecimalField(max_digits=15, decimal_places=2,null=True, blank=True)
    expected_cm2_revenue_after = models.DecimalField(max_digits=15, decimal_places=2,null=True, blank=True)
    current_llr = models.DecimalField(max_digits=5, decimal_places=2,null=True, blank=True)
    llr_threshold_zero_sum = models.DecimalField(max_digits=5, decimal_places=2,null=True, blank=True)

    reason = models.ForeignKey(Reason, on_delete=models.SET_NULL, null=True, blank=True)
    comment = models.TextField(null=True, blank=True)
    created_by = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='llr_assumptions_created')
    created_date = models.DateTimeField(default=timezone.now)
    def __str__(self):
        return f"{self.payment_plan} - Estimated LLR: {self.predicted_llr}"


class SalesProjection(models.Model):
    product_detail = models.CharField(max_length=255)  # you can adjust the max_length as needed

    anticipated_growth = models.DecimalField(max_digits=5, decimal_places=2)
    price_change = models.DecimalField(max_digits=5, decimal_places=2)
    total_volume_before = models.IntegerField()
    total_volume_after = models.IntegerField()
    unit_price_before = models.DecimalField(max_digits=10, decimal_places=2)
    unit_price_after = models.DecimalField(max_digits=10, decimal_places=2)
    gross_revenue_before = models.DecimalField(max_digits=15, decimal_places=2)
    gross_revenue_after = models.DecimalField(max_digits=15, decimal_places=2)
    current_priced_cm2_before = models.DecimalField(max_digits=5, decimal_places=2)
    current_priced_cm2_after = models.DecimalField(max_digits=5, decimal_places=2)
    expected_cm2_revenue_before = models.DecimalField(max_digits=15, decimal_places=2)
    expected_cm2_revenue_after = models.DecimalField(max_digits=15, decimal_places=2)
    current_llr = models.DecimalField(max_digits=5, decimal_places=2)
    llr_threshold_zero_sum = models.DecimalField(max_digits=5, decimal_places=2)
    
class PaymentPlanProjection(models.Model):
    plan_name = models.CharField(max_length=100)
    product_cost = models.DecimalField(max_digits=10, decimal_places=2)
    projections = JSONField()

    def __str__(self):
        return f"{self.plan_name} - Projections"
    

    