Date: Wed, 26 Nov 2003 17:33:29 +0100
From: Tom <tom@lemuria.org>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Problems with /dev/tty on reboot.
Message-ID: <20031126173328.C6812@lemuria.org>
References: <3FC4AF2B.3060301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FC4AF2B.3060301@redhat.com>; from dwalsh@redhat.com on Wed, Nov 26, 2003 at 08:48:27AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 26, 2003 at 08:48:27AM -0500, Daniel J Walsh wrote:
> is not a clean solution.  Also this can probably happen to other files 
> that have their contexts changed by running processes.  Ideas on how to 
> solve this problem??

Your solution doesn't sound too bad.

Have a config file, say /etc/selinux/required_file_contexts and call
setfiles from an init script very early.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
