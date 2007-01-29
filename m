Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0TFCRja013732
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 10:12:27 -0500
Received: from web51501.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l0TFDSfV024473
	for <selinux@tycho.nsa.gov>; Mon, 29 Jan 2007 15:13:28 GMT
Date: Mon, 29 Jan 2007 07:13:27 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: missing avc message field names
To: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc: Steve G <linux_4ever@yahoo.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <45BE0B8D.4080401@mentalrootkit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <602284.30232.qm@web51501.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>And if the library doesn't handle old format it makes it hard to choose 
>it for a project. 

True, hence the question about special-casing it. But to do that, we have to
agree on a name that the API will use to present it.

>I can't imagine dropping that for the audit library if it would mean losing
>compatibility for everything before this format change (i.e., all currently
>shipping selinux systems).

Agreed. I don't want to lose backwards compatibility either.

-Steve


 
____________________________________________________________________________________
Now that's room service!  Choose from over 150,000 hotels
in 45,000 destinations on Yahoo! Travel to find your fit.
http://farechase.yahoo.com/promo-generic-14795097

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
