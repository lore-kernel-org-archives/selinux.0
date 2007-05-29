Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4TLDmB5024430
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 17:13:48 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4TLDlIh019997
	for <selinux@tycho.nsa.gov>; Tue, 29 May 2007 21:13:47 GMT
Subject: Re: audit2allow module generation
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Anand Patel <apatel@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588BF0075@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588BF0075@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 29 May 2007 17:11:59 -0400
Message-Id: <1180473119.10202.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-05-29 at 16:25 -0400, Anand Patel wrote:
> I am trying to use audit2allow to generate module out of audit messages.
> 
> So, I installed refpolicy headers first. Then tried sepolgen-ifgen 
> 
> %sepolgen-ifgen
> % ... some output ...
> %parsing file /usr/share/selinux/devel/include/services/snmp.if
> %error parsing file /usr/share/selinux/devel/include/services/snmap.if:
> %could not parse text: "Syntax error on line 1 ( [type=OPAREN]"
> 
> Parser had problem parsing almost all if files and generated above
> error.

The problem is that the refpolicy "language" is far from fixed and
parsing it cleanly is almost impossible because of M4. So the parser
sometimes gets out of sync with refpolicy (hence the policyrep work).

I just need some more specific information about the refpolicy version
you are using and I should be able to fix-up the parser.

Thanks - Karl

> It would been helpful if error included correct line number.
> Is it parser bug? 
> Am I doing anything wrong?
> Is there any documentation available on how to use this policy
> generation tools?
> What are the dependencies these tools have?
> 
> 
> Thanks,
> 
> Anand Patel
> Tresys Technology
> apatel@tresys.com
> 410-290-1411xt153 
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
