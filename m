Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i84DsvrT014088
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 09:54:57 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i84Dsup9015009
	for <selinux@tycho.nsa.gov>; Sat, 4 Sep 2004 13:54:56 GMT
Date: Sat, 4 Sep 2004 15:06:09 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@debian.org>
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: [idea] file contexts "alternate" keyword
Message-ID: <20040904140609.GF4084@lkcl.net>
References: <20040903165723.GA31857@lkcl.net> <20040903205348.GA4084@lkcl.net> <1094258021.29689.32.camel@wintermute.xmldesign.de> <200409041748.38442.russell@coker.com.au> <1094297930.6427.7.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1094297930.6427.7.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Sep 04, 2004 at 01:38:50PM +0200, Erich Schubert wrote:
> Hi,
> 
> > This sounds like a reasonable feature request.  But we need a good way of 
> > implementing it.
> 
> We could require that they have the exact same pattern and follow each
> other in the file_contexts file.
> Maybe adding some flag as suggested earlier, like "alternate".
> 
> /var/www(/.*)?      system_u:object_r:httpd_sys_script_exec_t  alternate
> /var/www(/.*)?      system_u:object_r:httpd_sys_content_t
> 
> (maybe adding "default" to the second, to make it more userfriendly)
 
 the solution to ensuring that a setfiles run (make relabel)
 is done correctly is to record, in a separate file/database
 (e.g.  file_context_alt_labels) what the present "fourth
 parameter" is.

 [a database would be better than a flat file].

 the index would need to be the regexp (e.g. /var/www/(/.*)?) and the
 data would need to be the "fourth parameter" (e.g. "alternate").

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
