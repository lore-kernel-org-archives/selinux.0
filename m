Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, SELinux@tycho.nsa.gov,
        rmayo@caci.com
Subject: Re: Domain transition
Date: Mon, 16 Dec 2002 23:07:52 +0100
References: <200212162125.QAA00730@moss-shockers.ncsc.mil>
In-Reply-To: <200212162125.QAA00730@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200212162307.52976.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 16 Dec 2002 22:25, Stephen D. Smalley wrote:
> What's the point of limiting the user to a single role at login time if he
> can change it subsequently via newrole?  Of course, you could limit login
> to transition to a single user domain if you want to force all users to
> initially login with a certain role/domain.

We currently have the default policy for sshd not allowing it to transition to 
sysadm_t to limit the damage from sshd being cracked.

I guess there's potential for a very paranoid (*) person to want to do the 
same with login.

(*)  /bin/login has had a good history in terms of security for almost 10 
years now, unlike sshd.  Also /bin/login can't be accessed anywhere nearly as 
easily as sshd.  Of course I'm sure there are some very paranoid people 
here...  ;)

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
