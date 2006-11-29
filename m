Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATItQUx027893
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 13:55:26 -0500
Received: from web36607.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kATIsga4004363
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 18:54:43 GMT
Date: Wed, 29 Nov 2006 10:55:18 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [PATCH 0/3] NetLabel: add the remaining CIPSO tag types from the IETF draft
To: paul.moore@hp.com, netdev@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <20061129181817.505281000@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <889357.90007.qm@web36607.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- paul.moore@hp.com wrote:

> This patchset consists of three patches that add
> support for the remaining two
> tag types from the CIPSO draft specification, the
> enumerated and range tags.
> The most significant part about adding these two
> tags is that NetLabel now has
> the ability to represent more than 240 categories
> (limitation imposed by the
> current restricted bitmap tag).
> 
> In addition, the first patch in the set converts
> NetLabel's contiguous char
> string category bitmap stored in network friendly
> bit/byte order into a sparse
> bitmap stored in host friendly bit/byte order. 
> While this change was not
> required to support the new CIPSO tags, it should
> make life much easier as the
> old category bitmap would have proven problematic as
> the number of usable
> categories increases with the new tag types.  It
> also has a side effect of
> making the LSM specific code much less ugly.

Fabulous. Thank you.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
