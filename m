Message-ID: <3FA72765.5020802@redhat.com>
Date: Mon, 03 Nov 2003 23:13:25 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Richard Herbert Wanner <richard.wanner@cgi.com>
CC: SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: GDM and PAM problems?
References: <GMECJOINLDFDGEEPGINLMEMBCKAA.richard.wanner@cgi.com>
In-Reply-To: <GMECJOINLDFDGEEPGINLMEMBCKAA.richard.wanner@cgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Richard Herbert Wanner wrote:

>I have built a 2.6 Kernel on top of Fedora (test 3) using Dan Walsh's selUpgrade script.  It worked like a charm.
>
>There does seem to be a problem with GDM and PAM with those RPMs.  If I install the GDM and PAM RPMs, I get an error of "Cannot get default context for jadmin" right after login with the jadmin user (or any other user).
>
>Without the GDM and PAM RPMs it works great!
>
>Anybody know what the solution might be?
>
>Thanks
>Rick
>
>/etc/security/selinux/src/policy/domains/program
>  
>

>  
>
You have to relabel the files after you install them.  Make sure you 
copy the xserver.te and xdm.te from 
/etc/security/selinux/src/policy/domains/program/unused to
/etc/security/selinux/src/policy/domains/program
cd /etc/security/selinux/src/policy
make relabel
Restart Xserver.

>  
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
