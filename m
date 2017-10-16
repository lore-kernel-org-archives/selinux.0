Date: Mon, 16 Oct 2017 17:08:39 +0200
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jzarsky@redhat.com
Message-ID: <20171016150838.GB8669@pl-rpi.tpb.lab.eng.brq.redhat.com>
References: <20171011085345.31496-1-plautrba@redhat.com>
 <1507923099.15007.12.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507923099.15007.12.camel@tycho.nsa.gov>
Subject: Value of file_contexts.bin after the move to pcre2
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Oct 13, 2017 at 03:31:39PM -0400, Stephen Smalley wrote:
> We still need to revisit the value proposition of file_contexts.bin
> after the move to pcre2, given the large increase in file size and the
> runtime overhead.  We can add -r to the sefcontext_compile args via
> semanage.conf, but then I'm wondering whether it is worth having
> file_contexts.bin at all.

We already use -r in Fedora 27 by default.

Jan Zarsky did some investigation related to file_contexts.bin [1] and
according to his results, we it looks like we can simply drop file_contexts.bin
completely.

But there were some bugs in past which prevented Anaconda and systems
based on OSTree to work when there was no such file in
selinux-policy-targeted package. Therefore we need to confirm that if
we drop it in Fedora it wouldn't affect them.

Using this configuration in semanage.conf we can avoid creating such
files without any change in the code:

[sefcontext_compile]
path = /bin/true
[end]


[1] https://janzarskyblog.wordpress.com/2017/09/06/why-we-dont-need-to-ship-file_contexts-bin-with-selinux-policy/


Petr
