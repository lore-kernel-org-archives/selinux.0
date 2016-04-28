Subject: Re: Trying to setup a type bounds from unconfined_t and docekr_t to
 svirt_lxc_net_t
To: Stephen Smalley <sds@tycho.nsa.gov>, James Carter <jwcart2@tycho.nsa.gov>,
 SELinux <selinux@tycho.nsa.gov>,
 Joshua Brindle <brindle@quarksecurity.com>,
 Paul Moore <paul@paul-moore.com>
References: <805268ee-75d6-4c43-7014-2dc7dd5ae01e@redhat.com>
 <5e794e74-a733-f3e1-e47a-06ca2abc2f19@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Message-ID: <f1c8b9e7-31f7-a288-415b-82eb45021420@redhat.com>
Date: Thu, 28 Apr 2016 12:20:41 -0400
MIME-Version: 1.0
In-Reply-To: <5e794e74-a733-f3e1-e47a-06ca2abc2f19@tycho.nsa.gov>
Content-Type: multipart/alternative;
 boundary="------------598F8557070BFE2EB4716529"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------598F8557070BFE2EB4716529
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/28/2016 11:21 AM, Stephen Smalley wrote:
> On 04/28/2016 09:15 AM, Daniel J Walsh wrote:
>> >
>> >typebounds unconfined_t docker_t; # docker_t is an unconfined domain
>> >
>> >typebounds docker_t spc_t;  #spc_t is an unconfined domain
>> >
>> >typeboulds docker_t docker_lxc_net_t;
>> >
>> >
>> >docker, rkt, systemd-nspawn, runc are all executing
>> >setexeccon(svirt_lxc_net_t)
>> >
>> >For container domains.
>> >
>> >Everything works fine until I turn on expand_check in semanage.conf,
>> >which we have been asked to do in Rawhide.
>> >
>> >
>> >Attached is the current Rawhide docker policy.  And here is the output
>> >from semodule -i before it crashes, with a segfault.
>> >
>> >
>> >Had to add this rule to make it a little quieter, which is caused by a
>> >rule in policy that says we allow all daemons to connecto spc_t;
>> >
>> >gen_require(`
>> >type unconfined_t;
>> >attribute daemon;
>> >')
>> >
>> >allow daemon unconfined_t:unix_stream_socket  connectto;
>> >
>> >
>> >Why does typebounds care about when a domain is the target of an access,
>> >I think it should only remove options when it is the source.
>> >
>> >Otherwise we end up having to loosen the policy to make this work.
>> >
>> >As long as docker_t does not have any more "allow docker_t" rules then
>> >"allow unconfined_t", shouldn't this be ok?
>> >
>> >It seems that some or the optional code blocks are causing problems also.
> I agree that typebounds is not very usable in its current form, but I'm
> not entirely clear on how to fix it.
>
> Dropping the target bounds logic is possible; it was actually
> implemented a while back by KaiGai (see the archives) but reverted
> because of a side effect on /proc/pid file access.  Without the target
> bounds logic, you had to allow the parent domain to access all child
> domains' /proc/pid files in order for the child to access their own.
> That however could be worked around in policy, so possibly we could
> revive those patches.
>
> However, I don't think that solves all of the problems.  For example,
> even with source bounds, I can't allow a child permissions to self or to
> its entrypoint file type or to its tmp file type without allowing those
> permissions to the parent, which may unnecessarily escalate the
> privileges of the parent or expose the parent to risk.
>
> We might need more semantics in the policy about inter-type
> relationships in order to truly evaluate bounds in a manner that permits
> such usage.  Patches/proposals welcome.
>
> The other approach would be to use fork()+setcon()+execve() rather than
> fork()+setexeccon()+execve() in the callers.  Then you aren't subject to
> typebounds at all (NNP only restricts exec-based transitions).
The entrypoints are alot simpler to fix.  I think just eliminating the 
target checks would
go along way to making this a lot tighter policy.

I have no problem with allowing parent domain access to child domains 
self fields.  I think this
make some sense.  This seems a lot more secure that allowing any domain 
that can communicate
with the child to be able to communicate with the parent.

With the way it works now, I can not even figure out how to increase the 
privs of unconfined_t or
other confined domains to actually make it work.

--------------598F8557070BFE2EB4716529
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 04/28/2016 11:21 AM, Stephen Smalley
      wrote:<br>
    </div>
    <blockquote
      cite="mid:5e794e74-a733-f3e1-e47a-06ca2abc2f19@tycho.nsa.gov"
      type="cite">
      <div class="moz-text-plain" wrap="true" graphical-quote="true"
        style="font-family: -moz-fixed; font-size: 12px;"
        lang="x-unicode">
        <pre wrap="">On 04/28/2016 09:15 AM, Daniel J Walsh wrote:
</pre>
        <blockquote type="cite" style="color: #000000;">
          <pre wrap=""><span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>typebounds unconfined_t docker_t; # docker_t is an unconfined domain
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>typebounds docker_t spc_t;  #spc_t is an unconfined domain
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>typeboulds docker_t docker_lxc_net_t;
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>docker, rkt, systemd-nspawn, runc are all executing
<span class="moz-txt-citetags">&gt; </span>setexeccon(svirt_lxc_net_t)
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>For container domains.
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>Everything works fine until I turn on expand_check in semanage.conf,
<span class="moz-txt-citetags">&gt; </span>which we have been asked to do in Rawhide.
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>Attached is the current Rawhide docker policy.  And here is the output
<span class="moz-txt-citetags">&gt; </span>from semodule -i before it crashes, with a segfault.
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>Had to add this rule to make it a little quieter, which is caused by a
<span class="moz-txt-citetags">&gt; </span>rule in policy that says we allow all daemons to connecto spc_t;
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>gen_require(`
<span class="moz-txt-citetags">&gt; </span>type unconfined_t;
<span class="moz-txt-citetags">&gt; </span>attribute daemon;
<span class="moz-txt-citetags">&gt; </span>')
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>allow daemon unconfined_t:unix_stream_socket  connectto;
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>Why does typebounds care about when a domain is the target of an access,
<span class="moz-txt-citetags">&gt; </span>I think it should only remove options when it is the source.
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>Otherwise we end up having to loosen the policy to make this work.
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>As long as docker_t does not have any more "allow docker_t" rules then
<span class="moz-txt-citetags">&gt; </span>"allow unconfined_t", shouldn't this be ok?
<span class="moz-txt-citetags">&gt; </span>
<span class="moz-txt-citetags">&gt; </span>It seems that some or the optional code blocks are causing problems also.
</pre>
        </blockquote>
        <pre wrap="">I agree that typebounds is not very usable in its current form, but I'm
not entirely clear on how to fix it.

Dropping the target bounds logic is possible; it was actually
implemented a while back by KaiGai (see the archives) but reverted
because of a side effect on /proc/pid file access.  Without the target
bounds logic, you had to allow the parent domain to access all child
domains' /proc/pid files in order for the child to access their own.
That however could be worked around in policy, so possibly we could
revive those patches.

However, I don't think that solves all of the problems.  For example,
even with source bounds, I can't allow a child permissions to self or to
its entrypoint file type or to its tmp file type without allowing those
permissions to the parent, which may unnecessarily escalate the
privileges of the parent or expose the parent to risk.

We might need more semantics in the policy about inter-type
relationships in order to truly evaluate bounds in a manner that permits
such usage.  Patches/proposals welcome.

The other approach would be to use fork()+setcon()+execve() rather than
fork()+setexeccon()+execve() in the callers.  Then you aren't subject to
typebounds at all (NNP only restricts exec-based transitions).
</pre>
      </div>
    </blockquote>
    The entrypoints are alot simpler to fix.  I think just eliminating
    the target checks would <br>
    go along way to making this a lot tighter policy.<br>
    <br>
    I have no problem with allowing parent domain access to child
    domains self fields.  I think this <br>
    make some sense.  This seems a lot more secure that allowing any
    domain that can communicate<br>
    with the child to be able to communicate with the parent.<br>
    <br>
    With the way it works now, I can not even figure out how to increase
    the privs of unconfined_t or <br>
    other confined domains to actually make it work.
  </body>
</html>

--------------598F8557070BFE2EB4716529--
