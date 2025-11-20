from django import template

register = template.Library()

@register.filter(name='percentage')
def percentage(value):
    try:
        return float(value) / 100
    except (ValueError, TypeError):
        return None
