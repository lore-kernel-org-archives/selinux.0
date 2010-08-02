Subject: question about policydb_index_*
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 Aug 2010 14:48:09 -0400
Message-ID: <1280774889.20788.1.camel@dhcp231-200.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why do we have a separate policydb_index_classes() and
policydb_index_others() ?  It looks to me like I should be able to merge
them both into policydb_index_others().  Is there something I'm missing
or a reason I shouldn't do that?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
