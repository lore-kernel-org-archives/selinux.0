From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Matthew R. Singer" <msinger@itac.com>, <SELinux@tycho.nsa.gov>
Subject: Re: Default_Contexts
Date: Thu, 10 Apr 2003 10:18:35 +1000
References: <8A61167D13CED411B3E500B0D079784703AAF3@mailserver.itac.reston>
In-Reply-To: <8A61167D13CED411B3E500B0D079784703AAF3@mailserver.itac.reston>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bhLl+rEyexbk4re"
Message-Id: <200304101018.35150.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_bhLl+rEyexbk4re
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 10 Apr 2003 06:08, Matthew R. Singer wrote:
> Can someone give me a sample users .default_contexts file?
>
> I'm using get_ordered_sid_list() and it always returns 0.

Here's one of mine that worked on the previous release.  I presume that 
nothing has changed in this regard in the latest release, but it'll be at 
least a week before I can test it properly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_bhLl+rEyexbk4re
Content-Type: text/plain;
  charset="iso-8859-1";
  name=".default_contexts"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=".default_contexts"

system_r:local_login_t  second_r:second_t
system_r:sshd_t		second_r:second_t
system_r:crond_t	second_r:second_crond_t

--Boundary-00=_bhLl+rEyexbk4re--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
