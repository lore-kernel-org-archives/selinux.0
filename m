Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w8K7lfM1019587
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 03:47:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6404B3002709
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 07:47:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-217.brq.redhat.com
 [10.40.204.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C070E1001938
 for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2018 07:47:26 +0000 (UTC)
To: selinux@tycho.nsa.gov
References: <20180919205114.2683-1-nicolas.iooss@m4x.org>
From: Vit Mojzis <vmojzis@redhat.com>
Message-ID: <e3e0ae6a-4433-5b66-6410-f25f010a69f3@redhat.com>
Date: Thu, 20 Sep 2018 09:47:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180919205114.2683-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 1/1] python/sepolicy: fix compatibility with setools 4.2.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 19/09/2018 22:51, Nicolas Iooss wrote:
> When testing sepolicy gui with setools 4.2.0-beta, the following error
> happened:
>
>        File "python/sepolicy/sepolicy/__init__.py", line 277, in _setools_rule_to_dict
>          if isinstance(rule, setools.policyrep.terule.AVRule):
>      AttributeError: module 'setools.policyrep' has no attribute 'terule'
>
> This is due to a reorganization of files in setools 4.2. After reporting
> the issue on https://github.com/SELinuxProject/setools/issues/8 , it
> appears that sepolicy has not been using setools API properly. Fix this
> by:
> * replacing exception types internal to setools with AttributeError, as
>    they all inherit from it ;
> * using rule.conditional.evaluate(...) in order to find out whether a
>    conditional rule is enabled, instead of relying on
>    rule.qpol_symbol.is_enabled() (which disappeared).
>
> This last point required knowing the states of the booleans in the
> policy. As sepolicy already retrieves all boolean states in
> get_all_bools(), put them in a dict which can be used by
> rule.conditional.evaluate().
>
> This code has been tested with setools 4.1.1 and setools 4.2.0-beta.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>   python/sepolicy/sepolicy/__init__.py | 30 +++++++++++++++++++---------
>   1 file changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy/__init__.py b/python/sepolicy/sepolicy/__init__.py
> index 89346aba0b15..ed6dfea9718a 100644
> --- a/python/sepolicy/sepolicy/__init__.py
> +++ b/python/sepolicy/sepolicy/__init__.py
> @@ -112,6 +112,7 @@ login_mappings = None
>   file_types = None
>   port_types = None
>   bools = None
> +bools_dict = None
>   all_attributes = None
>   booleans = None
>   booleans_dict = None
> @@ -134,6 +135,7 @@ def policy(policy_file):
>       global all_domains
>       global all_attributes
>       global bools
> +    global bools_dict
>       global all_types
>       global role_allows
>       global users
> @@ -143,6 +145,7 @@ def policy(policy_file):
>       all_domains = None
>       all_attributes = None
>       bools = None
> +    bools_dict = None
>       all_types = None
>       role_allows = None
>       users = None
> @@ -272,34 +275,35 @@ def _setools_rule_to_dict(rule):
>           'class': str(rule.tclass),
>       }
>   
> +    # Evaluate the boolean condition if it is a conditional rule.
> +    # In order to do this, extract the booleans which are used in the condition first.
>       try:
> -        enabled = bool(rule.qpol_symbol.is_enabled(rule.policy))
> +        all_bools = get_all_bools_as_dict()
> +        used_bools = dict((str(name), all_bools[name]) for name in rule.conditional.booleans)
> +        enabled = rule.conditional.evaluate(**used_bools) == rule.conditional_block


Thank you for the patch, I've just been testing my version (almost 
identical except for this block).
Why don't you get the boolean state directly from the booleans inside 
the conditional?

try:
     #get state of all booleans in the conditional expression
     used_bools = {}
     for boolean in rule.conditional.booleans:
         used_bools[str(boolean)] = boolean.state
     #evaluate if the rule is enabled
     enabled = rule.conditional.evaluate(**used_bools) == 
rule.conditional_block

>       except AttributeError:
>           enabled = True
>   
> -    if isinstance(rule, setools.policyrep.terule.AVRule):
> -        d['enabled'] = enabled
> +    d['enabled'] = enabled
>   
>       try:
>           d['permlist'] = list(map(str, rule.perms))
> -    except setools.policyrep.exception.RuleUseError:
> +    except AttributeError:
>           pass
>   
>       try:
>           d['transtype'] = str(rule.default)
> -    except setools.policyrep.exception.RuleUseError:
> +    except AttributeError:
>           pass
>   
>       try:
>           d['boolean'] = [(str(rule.conditional), enabled)]
> -    except (AttributeError, setools.policyrep.exception.RuleNotConditional):
> +    except AttributeError:
>           pass
>   
>       try:
>           d['filename'] = rule.filename
> -    except (AttributeError,
> -            setools.policyrep.exception.RuleNotConditional,
> -            setools.policyrep.exception.TERuleNoFilename):
> +    except AttributeError:
>           pass
>   
>       return d
> @@ -930,6 +934,14 @@ def get_all_bools():
>       return bools
>   
>   
> +def get_all_bools_as_dict():
> +    """Return a name->state dict of the booleans defined in the policy"""
> +    global bools_dict
> +    if not bools_dict:
> +        bools_dict = dict((b['name'], b['state']) for b in get_all_bools())
> +    return bools_dict
> +
> +
>   def prettyprint(f, trim):
>       return " ".join(f[:-len(trim)].split("_"))
>   
