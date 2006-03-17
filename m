Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2IFGNsY027893
	for <selinux@tycho.nsa.gov>; Sat, 18 Mar 2006 10:16:23 -0500
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2IFGLlo006812
	for <selinux@tycho.nsa.gov>; Sat, 18 Mar 2006 15:16:21 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 18 Mar 2006 16:16:21 +0100
Message-Id: <34093.192.35.17.24.1142600323.squirrel@webmail.ifi.lmu.de>
In-Reply-To: <003301c64776$dd91f100$8c0d010a@columbia.tresys.com>
References: <36282A1733C57546BE392885C0618592010BB70E@chaos.tcs.tcs-sec.com>
    <003301c64776$dd91f100$8c0d010a@columbia.tresys.com>
Date: Fri, 17 Mar 2006 13:58:42 +0100 (CET)
Subject: RE: [PATCH] MLS interface update
From: "Thomas Bleher" <bleher@informatik.uni-muenchen.de>
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>>> The interface additions would be ok, but upon closer examination of
>>> the constraints, why are the reads traditional BLP
>>> (l1 dom l2), but the writes aren't (l1 eq l2 for { file lnk_file
>>> fifo_file }, and (l1 dom l2 and l1 domby h2) for { dir chr_file
>>> blk_file sock_file })?  In fact, the (l1 dom l2 and l1 domby h2)
>>> doesn't look correct to me; (l1 domby l2) seems right.  It appears
>>> the write constraints are being used for integrity (at least for
>>> file, lnk_file and fifo_file), but we already have TE for this
>>> purpose.
>>
>> The MLS BLP write policy has been modified to write equality, instead
>> of allowing unrestricted writeup. Unrestricted writeup is usually not
>> desired and is not even allowed by DCID 6/3. DCID 6/3 requires at
>> least write limitation to the user's clearance. We have the *toclr
>> attributes to achieve the clearance restrictions if desired. The {
>> dir chr_file blk_file sock_file } case is to handle ranged objects
>> whereas { file lnk_file fifo_file } have constraints to disallow them
>> from being ranged.
>
> I don't want to re-open my debate from a year ago about the value and
> desirability of write up in MLS systems and the ability to have untrusted
> MLS aware applications (i.e., I disagree with Chad's comment above :-)
> Perhaps the correct answer is to have primitive interfaces that implement
> the true BLP "no write down, no read up" rules and an added interface that
> encapsulates "no write down" with "only write equal" so that if others
> want
> to use the (IMHO highly desirable) write up ability, they can do so within
> the reference policy framework.

Is there some paper or reference on the pros and cons of "write up" versus
"write equal"? I'm trying to gain a better understanding of MLS and how it
is implemented in different systems.
Any pointers would be greatly appreciated!

Thanks,
Thomas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
