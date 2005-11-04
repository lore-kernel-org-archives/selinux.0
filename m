Message-ID: <436BE27A.9080906@redhat.com>
Date: Fri, 04 Nov 2005 17:36:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jonathan Kim <jkim@TrustedCS.com>
CC: SELinux@tycho.nsa.gov, Chad Hanson <chanson@TrustedCS.com>,
   Daniel Thayer <dthayer@TrustedCS.com>
Subject: Re: [PATCH] MLS policy
References: <36282A1733C57546BE392885C0618592D9770C@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592D9770C@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jonathan Kim wrote:
> This patch sets the file context for the seusers file to be
> SystemHigh (because the seusers file contains MLS labels and
> these must be protected).  It also fixes some login-related
> issues on MLS (allow login on a tty which is not at SystemLow,
> and also allow reading of the seusers file).
>   
Added to rev selinux-policy-targeted-1.27.2-15

>
>  <<mls-login.patch>> 
>
> -----------------------------------
> Jonghoon Jonathan
> Secure Systems Engineer
>
> Trusted Computer Solutions
> 121 W Goose Alley
> Urbana, IL  61801
>
> http://www.TrustedCS.com
>
> V:  217.384.0028  ext.16
> F:  217.384.0288
>
>   


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
