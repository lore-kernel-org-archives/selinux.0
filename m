Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAJ0QOAd020204
 for <selinux@tycho.nsa.gov>; Wed, 18 Nov 2015 19:26:25 -0500
Received: by obbnk6 with SMTP id nk6so47664516obb.2
 for <selinux@tycho.nsa.gov>; Wed, 18 Nov 2015 16:26:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMN686Hqhqa7D5Thxo5aUGNt+Mt3x+iyB7nCaWn9DFHkfct2ow@mail.gmail.com>
References: <CAMN686Hqhqa7D5Thxo5aUGNt+Mt3x+iyB7nCaWn9DFHkfct2ow@mail.gmail.com>
Date: Wed, 18 Nov 2015 19:26:14 -0500
Message-ID: <CAMN686ETg0+y=fae4q=W3azjDoOAoxvrLjGXGM_NQwTb0_5hBA@mail.gmail.com>
Subject: Re: Obtaining Default Context for SELinux Users
From: Mike Palmiotto <mike.palmiotto@crunchydata.com>
To: selinux@tycho.nsa.gov
Cc: Joe Conway <joe.conway@crunchydata.com>,
 Adam Brightwell <adam.brightwell@crunchydata.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Nov 18, 2015 at 5:09 PM, Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
> We're currently running into issues attempting to get a default
> context for a newly added SELinux user.
>
> The user has been added with semanage, and associated with a few
> roles. There are role declarations and allows (to and from the "scon"
> role) in place in the policy. We've also added entries to
> /etc/selinux/mls/contexts/{default_contexts,users/foo_u} to facilitate
> getting a default context for the SELinux user.
>
> The desire is to switch security labels based on the specified user's
> default context, like so:
> root:staff_r:staff_t:s0 -> foo_u:foo_r:foo_t:s0
>
> We're using a call to `get_default_context("foo_u",
> "root:staff_r:staff_t:s0", &new_context)` to get the default, but that
> doesn't seem to be finding working.
>
> In testing with a more verbose version of security_compute_user_raw,
> we noticed that the list of available contexts for foo_u are empty.
> This behavior has been noted for staff_u as well.
>
> Curious to know if there's something glaringly obvious that we're missing.

Other than this discussion (and previous discussions on using
security_compute_user), of course:
http://marc.info/?l=selinux&m=144707899910491&w=2

I'm still curious as to why the get_default_context mechanism is not
finding any reachable contexts.

--Mike

>
> Respectfully,
> Mike
