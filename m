Date: Thu, 24 Oct 2002 12:31:58 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: apache 2 patch
Message-ID: <20021024123158.A31929@lemuria.org>
References: <20021024115304.A31446@lemuria.org> <200210241221.22217.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200210241221.22217.russell@coker.com.au>; from russell@coker.com.au on Thu, Oct 24, 2002 at 12:21:22PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Oct 24, 2002 at 12:21:22PM +0200, Russell Coker wrote:
> I've changed my policy tree to allow httpd_t to read symlinks with the config 
> type.  I've attached the new policy file.
> 
> I don't know why you put in the line about sysadm_devpts_t as admin_tty_type 
> covers that.

Ok, I'll change that back. After trying all sorts of less restrictive
rules, I settled for what newrules-selinux gave me, given that this
addresses only that which raises the denials.


> My idea is to have run_init run a wrapper process (in the 
> system_u:system_r:initrc_t context) that will open a new pseudo-tty.  

That would essentially be my idea c)
Then I will leave this in for now and wait for your wrapper.

I'm now working on some other aspects, so there will likely be another
apache patch within the week.



> PS  Please use the Unified mode of diff (IE the "-u" option).

Will try to remember for next time. :)



-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
