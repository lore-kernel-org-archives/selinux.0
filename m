Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: Fractal Based Encryption
Date: Wed, 27 Mar 2002 15:42:57 +0100
Cc: <SELinux@tycho.nsa.gov>, reiserfs-list@namesys.com
References: <Pine.GSO.4.33.0203270852180.8022-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0203270852180.8022-100000@raven>
MIME-Version: 1.0
Message-Id: <20020327144257.CEF8341F4A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 27 Mar 2002 14:55, Stephen Smalley wrote:
> On Wed, 27 Mar 2002, Russell Coker wrote:
> > Why would encryption need to be integrated into SE Linux?
> >
> > Sure people who want SE Linux want encryption.  But why do they need to
> > be directly connected?
>
> They don't have to be directly connected (e.g. you can use FreeSWAN IPSEC
> orthogonally with SELinux), but there are some reasons to consider tighter
> integration.  See Pete's earlier email on this topic at
> http://marc.theaimsgroup.com/?l=selinux&m=98175653726530&w=2.

OK, that makes sense.

Pete's message seems to just imply making decisions regarding whether to 
encrypt or what type of encryption to use just based on domain. However I 
think (and I'm sure you and Pete have already considered this) that to do 
this properly you would want a framework where different file types are 
encrypted with different keys and could be selectively locked and unlocked.

For example, I have on my laptop ssh keys that give me access to client's 
machines (before someone makes nasty comments - when you travel to numerous 
sites and need to login via ssh there is no other option).  The ssh-askpass 
program has a number of limitations, so instead I'd like to be able to 
encrypt the ssh id_rsa files in the kernel, and have a utility program to 
unlock or lock these files (unlocking them would involve storing the 
encryption password in the kernel).  Then we would need a "fuser -k" type 
facility to force programs to stop using files when they are to be locked 
again.

This brings me to another issue I have been considering, that of newrole 
passwords.  It's standard proceedure to have root and user passwords be 
different even if you only login as a regular user for the purpose of "su -". 
Therefore I am concerned that we are limited by the utility programs only 
supporting the regular password for doing a "newrole -r sysadm_r".

I would like the option to be able to enforce that a login only gets the 
default role (no prompting for other roles or domains) and then have 
different passwords needed to get to roles or domains that have more privs.

Another thing, it would be nice if the run_init and newrole programs prompted 
you for which user's password they expected.  Often when I've su'd to root I 
forget which account I originally logged in with, then newrole and run_init 
fail because I entered the password for the wrong account.  In my Debian 
package I've added the account name to the error message so at least you can 
get it right the second time.

I've CC'd this message to the ReiserFS list as people there have been 
discussing file system encryption recently.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
