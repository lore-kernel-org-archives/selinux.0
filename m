Message-ID: <4564B480.3080302@tresys.com>
Date: Wed, 22 Nov 2006 15:35:12 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: More  small fixes to policycoreutils
References: <6FE441CD9F0C0C479F2D88F959B015885C7D9F@exchange.columbia.tresys.com> <4564AE17.5040502@redhat.com>
In-Reply-To: <4564AE17.5040502@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> No verbose flag for semanage, fix man page.
> 
> 
> ------------------------------------------------------------------------
> 
> diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/semanage/semanage.8 policycoreutils-1.33.4/semanage/semanage.8
> --- nsapolicycoreutils/semanage/semanage.8	2006-11-20 12:19:55.000000000 -0500
> +++ policycoreutils-1.33.4/semanage/semanage.8	2006-11-22 14:11:25.000000000 -0500
> @@ -82,10 +82,7 @@
>  .TP
>  .I                \-T, \-\-trans
>  SELinux Translation
> -.TP
> -.I                \-v, \-\-verbose    
> -verbose output
>  
>  .SH EXAMPLE
>  .nf
>  

Acked-By: Joshua Brindle <method@manicmethod.com>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
