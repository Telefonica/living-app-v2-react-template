from laqacommons.steps.environment import (
    after_all as qa_commons_after_all,
)
from laqacommons.steps.environment import (
    after_feature as qa_commons_after_feature,
)
from laqacommons.steps.environment import (
    after_scenario as qa_commons_after_scenario,
)
from laqacommons.steps.environment import (
    after_step as qa_commons_after_step,
)
from laqacommons.steps.environment import (
    before_all as qa_commons_before_all,
)
from laqacommons.steps.environment import (
    before_feature as qa_commons_before_feature,
)
from laqacommons.steps.environment import (
    before_scenario as qa_commons_before_scenario,
)
from laqacommons.steps.environment import (
    before_step as qa_commons_before_step,
)


def before_step(context, step):
    """Execute qa commons before step.
    :param context: Behave context
    :param step: step
    :return:
    """
    qa_commons_before_step(context, step)


def after_step(context, step):
    """Execute qa commons after step.
    :param context: Behave context
    :param step: step
    :return:
    """
    qa_commons_after_step(context, step)


def before_scenario(context, scenario):
    """Execute qa commons before scenario.
    :param context: Behave context
    :param scenario: scenario
    :return:
    """
    qa_commons_before_scenario(context, scenario)


def after_scenario(context, scenario):
    """Execute qa commons after scenario.
    :param context: Behave context
    :param scenario: scenario
    :return:
    """
    qa_commons_after_scenario(context, scenario)


def before_feature(context, feature):
    """Execute qa commons before feature.
    :param context: Behave context
    :param feature: feature
    :return:
    """
    qa_commons_before_feature(context, feature)


def after_feature(context, feature):
    """Execute qa commons after feature.
    :param context: Behave context
    :param feature: feature
    :return:
    """
    qa_commons_after_feature(context, feature)


def before_all(context):
    """Execute qa commons before all.
    :param context: Behave context
    :return:
    """
    qa_commons_before_all(context)


def after_all(context):
    """Execute qa commons after all.
    :param context: Behave context
    :return:
    """
    qa_commons_after_all(context)
