Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6HKu6Cn029585
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 16:56:06 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6HKu5FN022324
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 20:56:05 GMT
Subject: Re: [POLICYREP] [RFC/PATCH 2/3] policy package implementation
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <469D2B2B.1080704@manicmethod.com>
References: <20070717150336.135143158@manicmethod.com>
	 <20070717150431.660417962@manicmethod.com>
	 <1184686730.3833.11.camel@localhost.localdomain>
	 <469CF0EC.8030704@manicmethod.com>
	 <1184697355.3833.28.camel@localhost.localdomain>
	 <469D2B2B.1080704@manicmethod.com>
Content-Type: text/plain
Date: Tue, 17 Jul 2007 16:56:02 -0400
Message-Id: <1184705762.10625.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2007-07-17 at 16:48 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Tue, 2007-07-17 at 12:40 -0400, Joshua Brindle wrote:
> >   
> >> Karl MacMillan wrote:
> >>     
> > [...]
> >   
> >>>> +			// Currently we use the name of the file to decide what kind of file it is
> >>>> +			// I am fairly uncomfortable with this but it allows us to use xar to create
> >>>> +			// policy packages instead of having our own write_package function that 
> >>>> +			// assigns attributes to files instead of using names. 
> >>>>     
> >>>>         
> >>> I don't like this either - what is the alternative?
> >>>
> >>>   
> >>>       
> >> Ok, xar has an XML ToC for the file. It also provides an API to set 
> >> arbitrary attributes for each file, so I can do something like 
> >> selinuxfiletype = netfilter_contexts. This means that we would not be 
> >> able to use the command line xar to create packages (I was trying to 
> >> make this as simple as possible). If we move to using attributes we'd 
> >> have to have a custom packager again (ala semodule_package).
> >>
> >>     
> >
> > It would be simpler though, correct? And what about an unpackager?
> >   
> 
> Simpler in what way?

Simpler than our current semodule_package and all of the library support
behind it.

>  This first patch I was trying to keep it dead 
> simple by not even requiring a custom packager and instead just using 
> xar CLI. If we want to use more sophisticated things in xar (like 
> per-file attributes) we'd need something custom. Even if we just make a 
> subdocument (which is archive-wide in scope) and add some selinux bits 
> to it like policy name that can still be done with the CLI.
> 
> xar -xf foo.xar will unpackage it

Ok - then I vote for a custom packaging tool. If nothing else it can
retain some similarity to the current tool syntax.

[..]

> >>>
> >>>   
> >>>       
> >> There is no module_read function right now so thats just a placeholder.
> >>
> >>     
> >
> > There is if the module is source :)
> >
> >   
> 
> nak.

Why? Last time we discussed it you wanted support for storing additional
information but the only examples that you had were original filename
and line number. This is already supported (it has to be for the M4
processing). So what else? If nothing else, why have an additional
format?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
