Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA23985
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 01:25:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id FAA06439
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 05:25:11 GMT
Received: from ducks.huff20may77.us ([63.147.7.154])
	by jazzswing.ncsc.mil  with ESMTP id FAA06435
	for <selinux@tycho.nsa.gov>; Sun, 28 Jul 2002 05:25:10 GMT
Subject: Re: Message from Secure Computing
From: "Edward J. Huff" <edward.huff@acm.org>
To: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: 
	<72222DC86846D411ABD300A0C9EB08A1015243CF@csoc-mail-box.csoconline.com>
References: 
	<72222DC86846D411ABD300A0C9EB08A1015243CF@csoc-mail-box.csoconline.com>
Content-Type: text/plain
Date: 28 Jul 2002 01:24:06 -0400
Message-Id: <1027833846.15983.127.camel@ducks.huff20may77.us>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2002-07-27 at 22:11, Westerman, Mark wrote:
> One thing we need to remember. The NSA contracted SCC to modify the 
> Linux kernel (is now and was GPL at the time). Under the term of 
> the GPL SCC lost any rights to enforce the Patent licensing fees. If 
> I remember correctly they were paid over 2M for this work. Under 
> the terms of the GPL you cannot later enforce licensing rights. It 
> was not the NSA or any other company that made the changes, but SCC. 
> So to Secure Computing you lost any right to enforce patent licensing when
> YOU did the work and sold that work to the NSA under the terms of 
> the GPL.

This is not accurate.  Releasing code under the GPL has no impact on
patent rights.  The copyright owner (Linus Torvalds in this case) has
the right to object to distribution of SE Linux if there is no patent
license.  The patent owner (SCC) as always has a license to sue whomever
they want for infringing the patent (I guess without much risk of
citation for frivolous suit).  The NSA might be able to sue SCC for
breach of contract if they did sue someone for infringement, but we
don't know the terms of the contract.

The GPL states 

http://www.gnu.org/copyleft/gpl.html

"For example, if a patent license would not permit royalty-free
redistribution of the Program by all those who receive copies directly
or indirectly through you, then the only way you could satisfy both it
and this License would be to refrain entirely from distribution of the
Program."

This (apparently) means that anyone who has a copy of SE Linux would not
be assured of permission to distribute it if the patent licenses were
revoked.  (But why does it say "royalty-free redistribution" instead of
"royalty-free use"?)

It does appear that at the present time, everyone has a license from SCC
(revocable by any successor of SCC) to use patents 4,621,321, 4,713,753,
and 4,701,840 in the context of SE Linux, so Linus Torvalds would not
have any basis for suing distributors of SE Linux unless and until the
patent license was revoked.  Also, it appears that the "Assurance" would
make it difficult for SCC to win an infringement suit against anyone
using SE Linux, since they have promised not to sue.

Of course, SCC (like anyone else) can sue whomever they want to, but in
this case, I would expect that the FSF and others would provide legal
assistance so that no one would have to capitulate simply because they
couldn't afford to pay a lawyer.

The "Statement of Assurance" has a typographical error:  4,6211,231
should read 4,621,321.

Publication / Filing dates:
US4713753 Dec. 15, 1987 / Feb. 21, 1985
US4621321 Nov. 4, 1986 / Feb. 16, 1984
US4701840 Oct. 20, 1987 / June 20, 1986

It is not entirely clear when these patents expire, but see
http://www.ssjr.com/interact.htm

The expiration dates might be:
US4713753 Feb. 21, 2005
US4621321 Feb. 16, 2004
US4701840 June 20, 2006

Apparently there are not many years left in these patents.  Also two of
them are subject to US Government rights.

I don't have access to the full list of claims.  uspto is down and
delphion wants $3 per patent.  Anyway, patent claims are almost
impossible to decrypt.

-- Ed Huff

-----------------------------------------------------------------
US4713753: Secure data processing system architecture with format
control

Country: US United States of America

Inventor: Boebert, William E.; Minneapolis, MN
Kain, Richard Y.; Minneapolis, MN

Published / Filed: Dec. 15, 1987 / Feb. 21, 1985

Application Number: US1985000703638

Government Interest:
    The present invention was developed in conjunction with the United
States Government Contract No. MDA 904-84-C-6011.

Priority Number:
Feb. 21, 1985  US1985000703638

Abstract: Means and methods of securing protected system files in a data
processing system are disclosed, wherein the information determining
access rights of system users to the protected systems files remains at
all times within a secure processor. Provision is also made for allowing
the display or labeling of protected data files only when markings
consistent with the security level of such files are also displayed or
included in the label. Furthermore, provision is also made for limiting
the access rights of users to protected system files based on a
comparison between the formats associated with said files and the
function or subsystem performing operations on behalf of the users. 

--------------------------------------------------------
US4621321: Secure data processing system architecture

Country: US United States of America

Inventor: Boebert, William E.; Minneapolis, MN
Kain, Richard Y.; Minneapolis, MN

Published / Filed: Nov. 4, 1986 / Feb. 16, 1984

Application Number: US1984000580910

Government Interest:
    The United States Government has rights in this invention pursuant
to the Contract No. MDA-904-82-C-0444.

Priority Number:
Feb. 16, 1984  US1984000580910

Abstract: A data processing system having an architecture for protecting
selected system files. The data processing unit includes a secure
processing unit operating in a manner independent of the operation of
the remainder of the data processing unit for storing and comparing
system file attributes and user entity attributes. The comparison of
attributes is performed in accordance with a table in the secure
processing unit containing the security context. The secure processing
unit alone is able to manipulate special data groups called
distinguished data objects. The secure processing unti also manipulates
a data object identifier that isolates the indentification of the system
files from the actual memory storage locations. Apparatus and method are
also disclosed for providing secure creation of protected system files
that in part eliminates interruption of the data processing system in
the process. The architecture also facilitates secure transfer of files
between data processing systems. 

US4701840: Secure data processing system architecture

Country: US United States of America

Inventor: Boebert, William E.; Hennepin, MN
Kain, Richard Y.; Hennepin, MN

Published / Filed: Oct. 20, 1987 / June 20, 1986

Application Number: US1986000876540

Priority Number:
Feb. 16, 1984  US1984000580910

Abstract: A data processing system having an architecture for protecting
selected system files. The data processing unit includes a secure
processing unit operating in a manner independent of the operation of
the remainder of the data processing unit for storing and comparing
system file attributes and user entity attributes. The comparison of
attributes is performed in accordance with a table in the secure
processing unit containing the security context. The secure processing
unit alone is able to manipulate special data groups called
distinguished data objects. The secure processing unit also manipulates
a data object identifier that isolates the identification of the system
files from the actual memory storage locations. Apparatus and method are
also disclosed for providing secure creation of protected system files
by in part eliminates interruption, the data processing system in the
process. The architecture also facilitates secure transfer of files
between data processing systems. 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
