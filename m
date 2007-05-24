Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4OF6Iel011163
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 11:06:18 -0400
Received: from web51510.mail.re2.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l4OF6HXo004693
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 15:06:18 GMT
Date: Thu, 24 May 2007 08:05:57 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
To: Mark Goldman <mgoldman@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1180015458.3930.173.camel@tresys-winxppro>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <608941.10928.qm@web51510.mail.re2.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


<snip>
> > +	for (h = homedirs; h; h = h->next) {
> > +		s1len = strlen(h->data);
> > +		temp = malloc(s1len + sizeof("/[^/]*"));
> > +		strcpy(temp, h->data);
> > +		strcpy(temp + s1len, "/[^/]*");

could be:

for (h = homedirs; h; h = h->next) {
    asprintf(&temp, "%s/[^/]*", h->data);



> > +char *semanage_findval(char *file, char *var, char *delim)
> > +{
> > +	FILE *fd;
> > +
> > +	char *buff;
> > +	char *temp = NULL;
> > +
> > +	if (!file || !var || !delim)
> > +		return NULL;
> 
> assert?

Assert is bad as it calls SIGABRT. SIGABRT means dump core. Production software
should not be dumping core as a habit.

-Steve


       
____________________________________________________________________________________Sick sense of humor? Visit Yahoo! TV's 
Comedy with an Edge to see what's on, when. 
http://tv.yahoo.com/collections/222

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
