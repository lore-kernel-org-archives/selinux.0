Date: Tue, 10 Oct 2017 10:04:15 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <stephen.smalley@gmail.com>
cc: "Stephen D. Smalley" <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <CAB9W1A1s9phxBocqadVif1t58jp4is+1nssZmi1O95BJhHKvSw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1710101003480.9099@namei.org>
References: <20171002155825.28620-1-sds@tycho.nsa.gov>
 <20171002155825.28620-10-sds@tycho.nsa.gov>
 <1507217234.27146.14.camel@tycho.nsa.gov>
 <alpine.LRH.2.21.1710091250460.23916@namei.org>
 <CAB9W1A2-PT8QU-md1s9fxhNg+Cv0C4Xu-i1w_q0XzQ+K9rsyAg@mail.gmail.com>
 <CAB9W1A1s9phxBocqadVif1t58jp4is+1nssZmi1O95BJhHKvSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [RFC 09/10] selinux: add a selinuxfs interface to
 unshare selinux namespace
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 9 Oct 2017, Stephen Smalley wrote:

> On Oct 8, 2017 9:54 PM, "James Morris" <jmorris@namei.org> wrote:
> 
> On Thu, 5 Oct 2017, Stephen Smalley wrote:
> 
> > inet_socket test failures are expected due to running in a non-init
> > network namespace; they don't work even without unsharing the selinux
> > namespace.
> 
> Do these results all look as expected?
> 
> 
> No, that suggests that you either didn't insert the policy module allowing
> access to unlabeled fds or you didn't run restorecon -R /dev before running
> the tests. The only expected failures are the inet socket ones.
> 

Looking better now -- I think it was the restorecon.


-- 
James Morris
<jmorris@namei.org>
