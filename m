Subject: Re: pam_selinux when selinux is disabled
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <1104265628.21391.152.camel@moss-spartans.epoch.ncsc.mil>
References: <20041228202032.GA5296@lkcl.net>
	 <1104264941.21391.140.camel@moss-spartans.epoch.ncsc.mil>
	 <1104265628.21391.152.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 29 Dec 2004 17:14:14 +0530
Message-Id: <1104320654.3805.10.camel@jsingh>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

On Tue, 2004-12-28 at 15:27 -0500, Stephen Smalley wrote:
> BTW, sshd is no longer using pam_selinux; we had to go back to a direct
> patch due to changes in the upstream sshd.

I am not storing my username/password in standard /etc/passwd  but in
different files/DB.. so i have personalized getpwnam by
editing /etc/nsswitch.conf

thats works fine.

when you define users in a policy .. it calls python getpwnam and adds
user to selinux user db. So I guess even that is fine.

now .. the question is when login sets selinux context for a user which
system call it makes to get user identification and which system call it
uses to set the context.

If sshd is not relying on pam_selinux than .. is all this hard-coded in
sshd ???

Please clarify it.
Jaspreet.

-- 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
