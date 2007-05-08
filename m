Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l48MUHai020434
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2007 18:30:17 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l48MTkkG012153
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2007 22:29:47 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l48MTklf013633
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2007 18:29:46 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l48MTfrY021374
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2007 18:29:41 -0400
Received: from [10.11.14.127] (vpn-14-127.rdu.redhat.com [10.11.14.127])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l48MTeEw030950
	for <selinux@tycho.nsa.gov>; Tue, 8 May 2007 18:29:41 -0400
Subject: policyrep questions
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SE Linux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 08 May 2007 18:29:40 -0400
Message-Id: <1178663380.2379.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have a few questions as I continue to do the policyrep patches.

1) The free functions for the objects may need to return an error (which
I hate, but there is no good way to avoid this). This will break
compatibility with the existing string based sepol objects (like
sepol_bool). Any problems breaking this compatibility?

2) The general form of the free functions will be:

int sepol_object_free(struct sepol_handle *h, struct sepol_object *o);

Is the handle necessary? The general form is to pass a handle wherever
an error is possible, but it seems like overkill in this case.

3) The existing objects copy the passed in strings where I was hoping to
avoid the copy. Any opinions either way? I'm currently leaning towards
copying because that kind of change will create hard to track down bugs
for no good reason.

4) We assume NULL-terminated strings all over the place - should we be
providing apis with length? Alternatively, should we provide a better
string object (since we are currently re-inventing the wheel, why not?).
We could pull in something like James Antills Vstr library -
http://www.and.org/vstr/ (read and be amazed at the diligence of James).
It just seems crazy that our apis are not the safest.

Karl




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
