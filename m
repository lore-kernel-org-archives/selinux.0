Date: Fri, 6 Jun 2003 10:06:11 -0700
From: Rafal Wojtczuk <rafal@intruvert.com>
To: SELinux@tycho.nsa.gov
Subject: Re: A vulnerability in SELinux (fwd)
Message-ID: <20030606170611.GA701@emperor.intruvert.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Vayne Salomon>   'Sorry about the previously terse note, the version below
Vayne Salomon> was meant to be sent to an internal list first.
Bravissimo. Very responsible indeed. Why not to slashdot ?

Brian May> I had a feeling that LD_PRELOAD was somehow ignored if the exec
Brian May> would trigger a change in domain?
Obviously it is not. Obviously it should be.

Brian May> Can this be reproduced with 2.4.x? 
Yes.

Brian May> What is the label associated with libSegfault.so?
Read the advisory, or recall how "make relabel" works.

Brian May> IIRC A process needs exec rights in order to use a shared library.
Correct. That is why simple "LD_PRELOAD=./my_evil_library.so schfn" does not
work.

Carsten Grohmann> This time I can't reproduce it the in section II
Carsten Grohmann> descripted attack.
The ulimit syntax may depend on your bash version; you may have to use 
"ulimit -s 10".

Russel> Over the last few days on the #selinux list there has been 
Russel> discussion of these things.  The easiest implementation of such an 
Russel> attack (which was successfully used in practise) was to create a 
Russel> shell function named newrole() which gets
You mean, alter ~someuser/.bashrc ? At least in my setup (default policy), 
root:user_r:user_t has no access to ~root. 

RW

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
