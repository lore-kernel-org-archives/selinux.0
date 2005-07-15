Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FJQjgA013924
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 15:26:45 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FJN8rE017907
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 19:23:08 GMT
Subject: Re: [RFC] selinux management API
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42D7FC9A.7000901@tresys.com>
References: <42D7CC53.9030803@tresys.com>
	 <1121442990.4488.87.camel@celtics.boston.redhat.com>
	 <42D7FC9A.7000901@tresys.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 15:19:59 -0400
Message-Id: <1121455199.10134.15.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


int semanage_user_remove(semanage_handle_t *, semanage_user_t
*userdata);

You want to remove based on name, not based on a full
data structure. Similarly there should be a query function.

void semanage_user_free(semanage_user_t *);

Seems to me like the free functions should be declared
with the other handlers for their corresponding opaque 
data structure (which are not shown here).







--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
