MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: User object manager context location
Date: Fri, 27 Oct 2006 14:18:34 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158851467B@exchange.columbia.tresys.com>
In-Reply-To: <1161969870.17018.41.camel@moss-huskies.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <ewalsh@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Eamon Walsh [mailto:ewalsh@tycho.nsa.gov] 
> 
> > > Also, where should the files go, these are private 
> resources of the 
> > > object manager that libselinux doesn't know how to parse, the 
> > > contexts directory is (IMHO) a resource of libselinux so 
> it should 
> > > understand files there, on the other hand the object 
> labeling files 
> > > would be policy specific so they need to be handled in such a way 
> > > that policy changes don't break the object manager.
> 
> I think that configurations should be stored in the policy, 
> not in the individual object managers.  A large part of the X 
> code right now is just for parsing the text file that 
> provides the mapping at present.
> The common string->label model should solve the "random formats"
> problem.
> 

I'm still not convinced by this, an object manager will potentially be
labeling based on a config, picture an selinux aware apache that is
labeling vhosts, the vhosts are in the config file and somehow would
need to by synchronized with the contexts in the policy directory. Other
object managers are going to store their contexts with the objects (eg.,
postgresql). I don't know like disparity in the way labels are handled
and I'm not comfortable forcing object managers to store their contexts
in an external place.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
