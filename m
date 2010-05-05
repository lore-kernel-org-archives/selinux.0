From: Paul Moore <paul.moore@hp.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [RFC PATCH v1 2/6] selinux: Set the peer label correctly on connected UNIX domain sockets
Date: Wed, 5 May 2010 11:46:14 -0400
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
References: <20100503220455.8177.91177.stgit@flek.lan> <201005041134.16579.paul.moore@hp.com> <1273002437.30175.194.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1273002437.30175.194.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201005051146.14551.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 04 May 2010 03:47:17 pm Stephen Smalley wrote:
> On Tue, 2010-05-04 at 11:34 -0400, Paul Moore wrote:
> > I'm not in love with the names either, if you've got suggestions I'm all
> > ears (well, I suppose eyes is more apt unless you want to call me to
> > discuss the patches).
> 
> Take your pick:
> sksec_sock, sksec_other, sksec_newsk OR
> sksec_client, sksec_listener, sksec_server

Okey dokey; sksec_{sock,other,new} it is ...

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
