From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Pascal Hahn <p.hahn@laufwerka.de>
Subject: Re: apache rule to make it write in directory
Date: Fri, 25 Jun 2004 00:32:49 +1000
Cc: SELinux@tycho.nsa.gov
References: <40DACAF8.6000308@laufwerka.de>
In-Reply-To: <40DACAF8.6000308@laufwerka.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406250032.49303.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 24 Jun 2004 22:37, Pascal Hahn <p.hahn@laufwerka.de> wrote:
> I got the problem that my apache2 under selinux running on gentoo linux is
> not able to write to a certain directory under htdocs which i need to be
> writable.
>
> I need a rule to make it write in that directory but didnt find a
> possibility to do so by now.
>
> Perhaps someone can help me out here.

Please show us the AVC messages from the access that is denied and then it 
should be easy to demonstrate how to customise the policy to do what you 
require.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
