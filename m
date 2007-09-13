Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8DDDAY8020585
	for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2007 09:13:10 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8DDD9S2016876
	for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2007 13:13:10 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8DDD9AV022394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2007 09:13:09 -0400
Subject: Re: Inherited tpe definition
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46E93390.1030900@redhat.com>
References: <1189614281.4270.39.camel@localhost.localdomain>
	 <46E93390.1030900@redhat.com>
Content-Type: text/plain
Date: Thu, 13 Sep 2007 09:13:02 -0400
Message-Id: <1189689182.3538.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-09-13 at 08:56 -0400, Daniel J Walsh wrote:

[...]

> The best example of the need for inheritance is java/wine/mono/aida apps.
> 
> If a user runs one of these applications then they would need execmem,
> execstack Plus all of the existing privs of the user, plus all of the
> communications paths
> 
> So xguest_t and xguest_java_t need to be able to communicate fully
> together.  Any time I add access to xguest_t I would expect that access
> to be added to xguest_java_t.
> 
> I have experimented with doing this with attributes,
> attribute $1_user_type
> allow $1_user_type ...
> 
> Then you define xguest_t and xguest_java_t as xguest_user_types
> 
> But this falls down when you call an interface that uses self
> 
> allow xguest_user_type self:fifo_file rw_fifo_file_perms;
> 
> 
> Does not allow xguest_t xguest_java_t:fifo_file rw_fifo_file_perms;
> 
> So we need to look at every interface and make sure they don't use self.
> 

But that is also the best example of the complication of this language
feature: sometimes you want the new type to be confined from the old
type (the the related types - like httpd_conf_t in my example) and
sometimes you don't want them confined as you describe above.

I'd like to have some way for the person defining the inherited type to
make that choice so that it is useful when extending existing policies
(i.e., make it useful for admins rather in addition to upstream policy
developers).

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
