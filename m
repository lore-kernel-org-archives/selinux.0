Message-ID: <53BD65F7.6010503@tycho.nsa.gov>
Date: Wed, 09 Jul 2014 11:55:35 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux-NSA <SELinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
 Daniel J Walsh <dwalsh@redhat.com>
Subject: libselinux 2.3 incompatibility
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

According to:
http://upstream-tracker.org/versions/libselinux.html
we broke compatibility with libselinux 2.3 as a side effect of the
security_context_t removal patch (commit 9eb9c93).

The issue is that we replaced the previously erroneous const
security_context_t == char *const arguments with const char * (the
original intent when the const was first added) so we lose constness on
the pointer.  As per the binary compatibility report from the above site:

"Type of 1st parameter ctx has been changed from security_context_t
const to char const* (removed const qualifier).	This function may change
parameter ctx, but it will be treated as const by old client
applications. This may result in crash or incorrect behavior of
applications."

At the moment I don't think any harm results as we have not changed the
functions and thus they should not modify any of the previously const
pointers, but I'm wondering if we need to switch them all to const char
*const to avoid future incompatibility?
