Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l34FelH8014095
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2007 11:40:47 -0400
Received: from web86902.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l34FeI4G023210
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2007 15:40:19 GMT
Date: Wed, 4 Apr 2007 15:39:58 +0000 (GMT)
From: JanuGerman <doublemalam@yahoo.co.uk>
Subject: Re: Identification of Attribute values within the Security Server
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Message-ID: <557930.89616.qm@web86902.mail.ukl.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>avd->allowed is an "access vector", as described by our papers and
>reports (please read the available documentation before asking
>questions).  It is a bitmap of permissions that are allowed for the
>(ssid, tsid, tclass) triple.  The security server can at its discretion
>compute more than just the "requested" permissions and provide further
>decisions, as indicated by the avd->decided vector (which is also a
>bitmap).  Not sure what you mean by negative values - they are unsigned
>integers representing bitmaps.


Thanks.


>Possibly you should seek out and read the papers on LSM, e.g.
>http://www.usenix.org/event/sec02/wright.html
>http://www.kroah.com/linux/talks/ols_2002_lsm_paper/lsm.pdf

Unfortunately, there is not much information about the composition of the access vector "bitmap" in the above papers, not even in the document "Configuring an SELinux policy" i think so. Can one deduce that if the value avd->allowed is greater than 1, it is always allowed? Because, i have noticed that when the avd->allowed is greater than one, no matter any value, all other values are -1, may be i am wrong.

Thank You,
JG


		
___________________________________________________________ 
Copy addresses and emails from any email account to Yahoo! Mail - quick, easy and free. http://uk.docs.yahoo.com/trueswitch2.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
