Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2QKEGWs024951
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 16:14:16 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2QKEFRM029058
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 20:14:15 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2QKEE7r003312
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2007 16:14:14 -0400
Subject: Re: Elimination of disable_trans boolean ramifications
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46081AE0.5070703@redhat.com>
References: <46041166.8010102@redhat.com>
	 <1174927405.12204.51.camel@localhost.localdomain>
	 <46081AE0.5070703@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Mar 2007 16:12:13 -0400
Message-Id: <1174939933.15046.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-03-26 at 15:11 -0400, Daniel J Walsh wrote:
> Karl MacMillan wrote:

<snip>

> >
> > So - I like this idea from a technical point-of-view. The only concern
> > is that users are used to looking for a booleans for this type of thing.
> > There is some hope that they would discover the changed booleans poking
> > around a gui tool or using g/setsebool. I don't think most users would
> > never think to create a module to make a domain unconfined. Plus, the
> > directions on how to do this go from a single command to several.
> >
> > I've heard concern that the number of booleans is growing too large. I
> > would suggest that if that is your motivation for avoiding booleans that
> > we find a way to organize them instead.
> >
> > Karl
> >   
> I think turning a domain unconfined_domain should be the last resort.  
> (Or I guess better then chcon -t bin_t EXEC)
> 
> I think adding a boolean makes it too easy for them.
> 

I'm afraid that turning off selinux will be easier. I would rather a
user have a few unconfined domains than no selinux at all. 

> The response to an AVC would be best if it involved the following:
> 
> 1. Ignore AVC if the app works. Reporting a bugzilla against the package 
> that created it.  Leaked file descriptor or daemons trying to talk to 
> terminals are classic examples of this.
> 2. If setroubleshoot suggests a boolean or file_context to set then set 
> it and see if the app works.
> 3. audit2allow -M myEXEC -i /var/log/audit/audit.log  to "fix" the 
> policy for the app  (BUGZILLA)
> 4. New tool to create unconfined_domain policy package for running 
> daemon unconfined (BUGZILLA)
> 5. chcon -t bin_t EXEC (BUGZILLA)
> 6. setenforce 0 (BUGZILLA)
> 7. selinux=0 (BUGZILLA)
> 

I agree up until 4, which I'm afraid will become goto 6 instead. Both 4
and 5 require that the user have some idea of what to do and there are
no "bread crumbs" for them to follow to get there. Considering how long
we have been pushing the disable_trans booleans I hesitate to change
that process radically.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
