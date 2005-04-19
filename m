Date: Tue, 19 Apr 2005 18:29:54 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Paul Moore <paul.moore@hp.com>
cc: SELinux <SELinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: selinux-policy-mls is now available for your testing pleasure.
In-Reply-To: <42657740.9000005@hp.com>
Message-ID: <Xine.LNX.4.44.0504191827130.17819-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 19 Apr 2005, Paul Moore wrote:

>   5 Enabled the MLS policy via the Fedora GUI tool and ensured that the
>     relabel option was selected
>   6 Rebooted with the new MLS policy only to have the machine lock,
>     it wasn't able to execute something related to init (I should have
>     taken better notes here - sorry)

You still need to perform the manual mointpoint relabeling per the MLS 
readme.

> 10 Rebooted with 'single' and noticed lots of permission denied
>     messages pertaining to '/dev/.udevdb/*' files

Odd, I haven't seen that.

Did you update to all of the new SELinux packages in Dan's FTP directory?

> 12 Rebooted normally, i.e. 'rhgb quiet 5', and X failed to start

Haven't tried X yet, not sure it's supposed to work.


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
