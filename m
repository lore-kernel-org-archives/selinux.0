MIME-Version: 1.0
Date: Sun, 3 Apr 2011 13:35:36 +0200
Message-ID: <AANLkTinus_5iaHauJOPUmiMjqGYtPj+r=RFYjsWTiz5C@mail.gmail.com>
Subject: Named TYPE_TRANSITION and userspace AVC
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: Eric Paris <eparis@redhat.com>
Cc: SELinux-ML <selinux@tycho.nsa.gov>, Eamon Walsh <ewalsh@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We may have a possible issue regarding to the named TYPE_TRANSITION
feature and userspace avc.

Unlike kernel space, userspace avc caches a new security context towards
a combination of object class and SID pair.
In other words, we could identify each cache entries on uavc by these
identifiers
without name component. However, we have to add object name as an element
to identify cache entry after this.

If so, is the avc_compute_create() still meaningful?
In most cases, we don't try to create a new object with same name in same
class. Object manager shall raise an error before access control decision.

Even so, userspace avc may try to create cache entries for each combination
of object class, SID pair and object name, although this entry shall not be
referenced again.

The issue is not critical for SE-PostgreSQL case, because its frequency to
create named object (CREATE xxx statement) is relatively smaller than
any other DML statement. Each rows in table does not have its names,
so we can use none-cached interface on DML statement and continue to
depend on userspace avc on INSERT statement.

The question is whether avc_compute_create() should support named
TYPE_TRANSITION rules, or not.
In my opinion, userspace object manager should use the new
security_compute_create_name() instead, when it tries to obtain the
security context to be assigned on a new named object.

Any comments?

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
