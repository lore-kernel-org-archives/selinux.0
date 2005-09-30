Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8UIcpNs002263
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 14:38:51 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8UIWrbY011024
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 18:32:53 GMT
Received: from [192.168.2.105] (cpe-24-59-125-231.twcny.res.rr.com [24.59.125.231])
	by postoffice9.mail.cornell.edu (8.12.10/8.12.6) with ESMTP id j8UIX29W018432
	for <selinux@tycho.nsa.gov>; Fri, 30 Sep 2005 14:33:02 -0400 (EDT)
Message-ID: <433D8706.4070604@cornell.edu>
Date: Fri, 30 Sep 2005 14:42:14 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [ 4/9 ] [ SEMANAGE ] Database initialization Stage 1
References: <433CA7CA.6000207@cornell.edu> <433CAAE2.2000106@cornell.edu>
In-Reply-To: <433CAAE2.2000106@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>+/* Release a database */
>+void dbase_release(
>+	dbase_t* dbase) {
>+
>+	cache_entry_t *prev, *ptr;
>+	while (ptr != NULL) {
>+		prev = ptr;
>+		ptr = ptr->next;
>+		dbase->rtable->free(prev->data);
>+		free(prev);
>+	}
>+}
>  
>
This is obviously wrong - ptr is not initialized, but I'm sure it's 
fixed in one of those later patches (the last one..possibly)? Please 
merge the whole patchset if there's no design issues - if there's bugs 
I'd much rather fix them with followup patches, than by changing those.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
