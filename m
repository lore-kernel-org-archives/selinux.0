MIME-Version: 1.0
In-Reply-To: <4ADF4C77.7050109@gmail.com>
References: <4ADF2358.4050606@laganowski.net>
	 <1256138160.4061.200.camel@moss-pluto.epoch.ncsc.mil>
	 <4ADF2663.2030105@laganowski.net>
	 <1256138950.4061.206.camel@moss-pluto.epoch.ncsc.mil>
	 <87hbtsvhru.fsf@anzu.internal.golden-gryphon.com>
	 <4ADF3D2C.2030408@laganowski.net>
	 <1256144567.4061.223.camel@moss-pluto.epoch.ncsc.mil>
	 <4ADF4301.30705@kutulu.org> <4ADF4C77.7050109@gmail.com>
Date: Mon, 16 Nov 2009 14:09:00 -0800
Message-ID: <dd18b0c30911161409v26919694wb8dc6c6594ae635c@mail.gmail.com>
Subject: Re: 'make policy' issues
From: Justin Mattock <justinmattock@gmail.com>
To: Mike Edenfield <kutulu@kutulu.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Laganowski <eric@laganowski.net>,
        selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

after adding most of the patches, and
using flex from git, still getting an error from
checkpolicy. Now after searching
I ran into this:
http://aur.archlinux.org/packages.php?ID=13202
and sure enough after downgrading flex
the policy went through as it should.
(as for what/where? not sure, especially after adding
most if not all patches to the latest flex).


-- 
Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
