Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8TJHRNs019954
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 15:17:28 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8TJBeS2006094
	for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2005 19:11:40 GMT
Message-ID: <433C3D35.1000901@redhat.com>
Date: Thu, 29 Sep 2005 15:15:01 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: apache tunable expression
References: <1128017619.12449.10.camel@sgc.columbia.tresys.com>
In-Reply-To: <1128017619.12449.10.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:

>In the apache policy, there is this conditional expression:
>
>if (httpd_enable_cgi && httpd_unified && httpd_builtin_scripting
>    ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
>
>Why is the httpd_disable_trans boolean checked?  If the transition to
>httpd_t is disabled, why does it matter if these rules are enabled or
>not?
>
>  
>
First one used to be needed to prevent transition from sysadm_t but the 
new ifdef targeted removes the need.  It looks like the second one was 
never needed.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
