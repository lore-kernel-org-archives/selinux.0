Message-Id: <200506071451.j57Epo5F018028@gotham.columbia.tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Frank Mayer'" <mayerf@tresys.com>,
   "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'NSA Selinux Mailinglist'" <selinux@tycho.nsa.gov>
Subject: RE: couple validatetrans questions
Date: Tue, 7 Jun 2005 10:51:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <200506061740.j56HeH5F009471@gotham.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Am I correct in understanding that for constrain statements, t1 (and
> u1 & 
> r1) mean source type (user or role) and t2 (and u2 & r2) mean target.
> However, for validatetrans, t3 now means source (i.e., the subject
> process), and t1 now means "old" context and t2 "new" context (since
> validatetrans deals only with context relabel)?  
> 
> I expected *1 to stay meaning the source/subject context, but
> concluded it was as above. Did I miss something? 

To answer my own question (since no once else did :-), it is indeed the case
that t1 (usually?) means process in constrain statements but not for
validatetrans, where t3 now means process and t1 mean "old". Seems like for
consistency sakes t1 should always be process; and for validatetrans t2 old
and t3 new. Likewise for [lru]1. The change in perspective is a conceptual
barrier towards concisely explaining these two similar statements (constrain
and validatetrans). 

A trivial code change to make assuming there hasn't been extensive use of
validatetrans/mlsvalidatetrans. Until then I guess I'll just have to work
harder at explaining the subtle difference. 




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
