Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l63BhQ5K006794
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2007 07:43:26 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l63BhOgQ014673
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2007 11:43:24 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l63BhONw018367
	for <selinux@tycho.nsa.gov>; Tue, 3 Jul 2007 07:43:24 -0400
Subject: Re: Allowing apache to read custom types
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4689619E.7060200@redhat.com>
References: <1183387458.16330.15.camel@localhost.localdomain>
	 <4689619E.7060200@redhat.com>
Content-Type: text/plain
Date: Tue, 03 Jul 2007 07:43:17 -0400
Message-Id: <1183462997.21098.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-07-02 at 16:35 -0400, Daniel J Walsh wrote:
> Karl MacMillan wrote:
> > I had a coworker ask about how to allow apache to read a custom type for
> > a policy that he wrote. Essentially, the policy is not focused on web
> > pages so it is not really ideal for the types to be generated from the
> > apache templates. I couldn't find any interfaces to allow apache to read
> > external types (I understand that these would be "reverse" interfaces -
> > but it seems like the most convenient way).
> >
> > Am I just missing the best approach here?
> >
> > Karl
> >
> >
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> >   
> We could add an attribute
> 
> apache_readable and an interface to define it.
> 
> read_file_pattern(httpd_t,  apache_readable, apache_readable)
> read_file_pattern(httpd_sys_script_t,  apache_readable, apache_readable)
> 

And an interface to use it? Are there other "reverse" interfaces
already?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
