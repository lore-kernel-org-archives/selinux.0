Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA04015
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 00:41:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id EAA17867
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 04:40:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id EAA17863
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 04:40:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <blacknet@simplyaquatics.com>, "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: Re: shellutils
Date: Mon, 15 Jul 2002 06:40:52 +0200
References: <014d01c22b9b$d0591720$0a01a8c0@ed>
In-Reply-To: <014d01c22b9b$d0591720$0a01a8c0@ed>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_40X93NP50SJ62VUBZCDW"
Message-Id: <20020715044054.89D5CF0A@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_40X93NP50SJ62VUBZCDW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Mon, 15 Jul 2002 03:06, Ed Street wrote:
> It would be interesting to return bogus info to non sysadm_r users :)

>From strace output:
getsecsid()                             = 440
security_sid_to_context(440, "rjc:user_r:user_t", [18]) = 0

So unless you block ptrace access, block the ability to write to any type 
that is executable, and block all other ways of executing any code (IE fixing 
stack overflows in all programs the user may be able to run among other 
things) then such bogus info won't even slow down a smart attacker much.

Besides everyone is too familiar with misdirection regarding UID etc.  

I've attached a shell-script r00t expl01t for your amusement.  ;)

Run "./proba" then run "id".

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_40X93NP50SJ62VUBZCDW
Content-Type: application/x-shellscript;
  name="proba"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="proba"

IyEvYmluL3NoDQpjbGVhcg0KZWNobyAicjAwdCBieSBsY2FtdHVmIg0KZWNobyAiLS0tLS0tLS0t
LS0tLS0tIg0KZWNobw0KZWNobyAiUHJvc3plIGN6ZWthYywgc3p1a2FtIGtvcnplbmlhLi4uIg0K
ZWNobyAiS29yemVuIHpuYWxlemlvbnkgbmEgMTkyRDpbMDEwMl0uIg0KZWNobw0KY2QgL3RtcA0K
Y2F0ID5leC5jIDw8ZW9mDQppbnQgZ2V0dWlkKCkgeyByZXR1cm4gMDsgfQ0KaW50IGdldGV1aWQo
KSB7IHJldHVybiAwOyB9DQppbnQgZ2V0Z2lkKCkgeyByZXR1cm4gMDsgfQ0KaW50IGdldGVnaWQo
KSB7IHJldHVybiAwOyB9DQplb2YNCmdjYyAtc2hhcmVkIGV4LmMgLW9leC5zbw0KTERfUFJFTE9B
RD0vdG1wL2V4LnNvIHNoDQpybSAvdG1wL2V4LnNvIC90bXAvZXguYw0KZWNobw0KZWNobyAiVGhh
bmsgeW91IGZvciB1c2luZyByMDB0LiINCmVjaG8NCg0K

--------------Boundary-00=_40X93NP50SJ62VUBZCDW--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
