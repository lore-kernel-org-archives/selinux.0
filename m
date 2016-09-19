Subject: Re: sandox -X not working with recent Xephyr
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov,
 Petr Lautrbach <plautrba@redhat.com>
References: <940febc8-d309-bab6-9797-11c07cf722fb@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <de735099-3871-b9b6-a4cc-8dc67b36e58e@tycho.nsa.gov>
Date: Mon, 19 Sep 2016 10:39:45 -0400
MIME-Version: 1.0
In-Reply-To: <940febc8-d309-bab6-9797-11c07cf722fb@debian.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/18/2016 02:39 PM, Laurent Bigonville wrote:
> Hi,
> 
> It seems that sandbox -X is not working anymore on debian.
> 
> Xephyr (1.18.4) is giving me the following error:
> 
> _XSERVTransmkdir: ERROR: euid != 0,directory /tmp/.X11-unix will not be
> created.
> 
> The X socket is not created inside the sandbox and then the application
> can obviously not connect to it.
> 
> I'm not sure how this could be fixed, maybe let's seunshare create that
> directory?

I don't see this error on Fedora, which also has Xephyr 1.18.4, so maybe
they have a fix?

That is using the Fedora policycoreutils-sandbox package, which yields a
functioning sandbox -X, e.g. sandbox -X firefox works correctly.

However, if I install sandbox from upstream, e.g.

cd selinux
sudo make LIBDIR=/usr/lib64 SHLIBDIR=/lib64 install install-pywrap relabel

then sandbox -X firefox fails immediately, and I have the following in
the audit log:
type=SELINUX_ERR msg=audit(1474295659.424:2189):
op=security_bounded_transition seresult=denied
oldcontext=unconfined_u:unconfined_r:sandbox_x_t:s0:c658,c1002
newcontext=unconfined_u:unconfined_r:sandbox_x_client_t:s0:c658,c1002

So I guess there are other patches in the Fedora package that are needed?
