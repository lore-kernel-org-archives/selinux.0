Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA13944
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 06:22:32 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA11786
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 10:21:45 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id KAA11782
	for <selinux@tycho.nsa.gov>; Fri, 26 Jul 2002 10:21:43 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Brian May <bam@snoopy.apana.org.au>,
        NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
Subject: Re: IDENTIFIER
Date: Fri, 26 Jul 2002 12:22:25 +0200
References: <20020726032129.GD27354@snoopy.apana.org.au>
In-Reply-To: <20020726032129.GD27354@snoopy.apana.org.au>
MIME-Version: 1.0
Message-Id: <20020726102225.C748D155E@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 26 Jul 2002 05:21, Brian May wrote:
> Is it possible to relax the definition of IDENTIFIER:
>
> {letter}({letter}|{digit}|_)*   { return(IDENTIFIER); }
>
> Any one symbol would be OK, but suggested ones include ~!@%&-=/

~ is already taken to mean a logical not.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
