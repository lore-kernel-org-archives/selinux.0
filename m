Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2AH7XZ004303
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 05:17:08 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2AH6Aw007077
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 10:17:06 GMT
Date: Tue, 2 Nov 2004 10:28:00 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jaspreet Singh <jsingh@ensim.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: set/getxattrs - I am badly struck ..
Message-ID: <20041102102800.GW9643@lkcl.net>
References: <1099347144.9776.3.camel@jsingh> <1099347590.9784.3.camel@jsingh> <20041102003903.GR9643@lkcl.net> <1099378305.11007.13.camel@jsingh> <20041102091711.GU9643@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20041102091711.GU9643@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Nov 02, 2004 at 09:17:11AM +0000, Luke Kenneth Casson Leighton wrote:
> what _i_ did was restrict the system to only having one user: therefore
> i can get away with using fusexmp to proxy mount /home/sez to
> /Documents.
> 
> therefore, in the file contexts, i can get away without having to hack
> genhomedircon, i can just add a hacked-up entry like this
> files/misc/hack.sez.fc:
> 
> 			/Documents 		sez:object_r:user_t.
 
 correction: user_home_t.  or thereabouts.  can't remember now.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
