Subject: Re: writing rules to disallow a domain to read particular files
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: Colin Walters <walters@verbum.org>
Cc: nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <1098030922.15741.20.camel@x-infinity.verbum.private>
References: <1097940101.2569.5.camel@jsingh.india.ensim.com>
	 <1097948413.3872.3.camel@x-infinity.verbum.private>
	 <1098017660.2740.33.camel@jsingh.india.ensim.com>
	 <1098030922.15741.20.camel@x-infinity.verbum.private>
Content-Type: text/plain
Message-Id: <1098086321.5142.11.camel@jsingh.india.ensim.com>
Mime-Version: 1.0
Date: Mon, 18 Oct 2004 13:28:42 +0530
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, 

First of all .. at Ensim .. I am just trying to take an initiative
towards MAC and if it works then i would talk to my team for
implementing it. so far so good ... lets hope for the best ...
> 
> Right, so the second approach would be:
> 
> domains/misc/local.te:
> full_user_role(foocom_webmaster)
> full_user_role(barcom_webmaster)
> full_user_role(bazcom_webmaster)
> 
> users.te:
> 
> user jaspreet roles { foocom_webmaster_t barcom_webmaster_t };
> user bob roles { barcom_webmaster_t };
> user manoj roles { foocom_webmaster_t bazcom_webmaster_t };
> 


That was an eye opener .. i didn't know so much was possible with
SELinux. Could you pass me on some document which can elaborate on
policy rules and configuration (and discusses whats all possible with
these policies).

Just to test the above approach i tried the following on on my FC2 box
with FC3 selinux-files , but i had some bad time compiling my changes
...

I added to "users" file - 
role jaspreet user jsingh roles { user_r site1_t sysadm_r system_r };

and to domains/misc/local.te
full_user_role(jsingh);
allow site1_t httpd_config_t:file { getattr read write };

but had some nice errors when i did make policy, like - 

	Building file_contexts ...
	/usr/bin/checkpolicy -o policy.18 policy.conf
	/usr/bin/checkpolicy:  loading policy configuration from policy.conf
	domains/misc/local.te:1:ERROR 'unknown boolean read_default_t in
	conditional expression' at token 'read_default_t' on line 3815:
	#line 1
	if (read_default_t) {
	domains/misc/local.te:1:ERROR 'illegal conditional expression' at token
'allow' on line 3837:
	#line 1
	allow jsingh_t usr_t:file { { read getattr lock execute ioctl }
	execute_no_trans };
	/usr/bin/checkpolicy:  error(s) encountered while parsing configuration
	make: *** [policy.18] Error 1

a grep on the files (grep -r read_default_t *) revealed thats it has not
been defined ????


Jaspreet






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
