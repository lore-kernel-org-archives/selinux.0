From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Nagendra Tomar <tomer_iisc@yahoo.com>
Subject: Re: Fwd: "star -xattr" in SELinux enabled system
Date: Sat, 9 Jun 2007 13:47:49 +1000
Cc: SELinux@tycho.nsa.gov
References: <140001.5113.qm@web53711.mail.re2.yahoo.com>
In-Reply-To: <140001.5113.qm@web53711.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200706091347.50549.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 09 June 2007 01:04, Nagendra Tomar <tomer_iisc@yahoo.com> wrote:
> Russell Coker <russell@coker.com.au> wrote:Why do you need to extract many
> security contexts from a tar file in a rc script?
>
> I need to add files from an archive stored on flash to my RFS. This has to
> happen during boot. I have resolved this issue by extracting the required
> archives, before the SELinux policy is loaded, i.e from the initramfs' init
> script and not from the rc script as I mentioned before.

If you are going to run the script in question without confinement, then why 
not use an unconfined domain after the policy is loaded instead of doing it 
before policy load?

Setting contexts before the policy load means that the contexts can't be 
validated, and I can't think of any benefits to doing it in the initramfs.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
