Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7FFiAi7018138
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 11:44:10 -0400
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7FFi99K007835
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 15:44:09 GMT
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 15 Aug 2007 17:44:07 +0200
From: selinux770@tortenboxer.de
In-Reply-To: <1187009718.26008.19.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <20070815154407.250820@gmx.net>
MIME-Version: 1.0
References: <20070810101003.128080@gmx.net>	
 <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>	
 <20070810121259.128050@gmx.net>	
 <1186748504.7233.34.camel@moss-spartans.epoch.ncsc.mil>	
 <20070810130703.128070@gmx.net>	
 <1186751971.7233.70.camel@moss-spartans.epoch.ncsc.mil>	
 <20070810141236.128070@gmx.net>  <20070811180730.308640@gmx.net>
 <1187009718.26008.19.camel@moss-spartans.epoch.ncsc.mil>
Subject: Re: wrong magic number (using old sources)
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Are you cross-compiling from a system with different endianness?
Don't think so. I think both systems are little endian.

I played a little bit with the sources and i found a strange error:
Actuallay, the generated magic number is correct. I checked that with an hex editor and also within the next_entry() method in private.h
the buffer, the next_entry method returns is:
buffer[0]: 8c
buffer[1]: ff
buffer[2]: 7c
buffer[3]: f9
buffer[4]: 8
buffer[5]: 0
buffer[6]: 0
buffer[7]: 0

The method returns a void pointer, that is interpreted as an uint32_t (4 bytes) pointer (*buf). Printing the first two buffer entries now, i get:
*** before conversion: buf[0] : 7cff8c
***  after conversion: buf[0] : 8c007cff
*** before conversion: buf[1] : f9000008
***  after conversion: buf[1] : 8f90000

Whereas "before conversion" shows the hex interpretation of buf[i] before le32_to_cpu(buf[i]) is called, and "after conversion" shows the value afterwards. Something wents completely wrong. It seems like a 00 is added at the beginning of buf[0]. The magic number would be correct if we would drop this 00 and take the first byte of buf[1] instead. The strange thing is that, when i declare a 
   char *tmpbuf;
and set it to
   tmpbuf=(char *)buf;
the content is correct again:
***  buf as char: tmpbuf[0] : 8c
***  buf as char: tmpbuf[1] : ff
***  buf as char: tmpbuf[2] : 7c
***  buf as char: tmpbuf[3] : f9
***  buf as char: tmpbuf[4] : 8
***  buf as char: tmpbuf[5] : 0
***  buf as char: tmpbuf[6] : 0
***  buf as char: tmpbuf[7] : 0

I don't get the problem... why is
         buf[0]     = (00) 7c ff 8c and
(char *) buf[3...0] =  f9  7c ff 8c
?

This is obviously not an error within the selinux sources, but maybe you could help me anyway?!

Thanks in advance.

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
