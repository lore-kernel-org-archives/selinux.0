Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4IAf5Wd026042
 for <selinux@tycho.nsa.gov>; Sun, 18 May 2014 06:41:05 -0400
Received: by mail-ee0-f43.google.com with SMTP id d17so2734480eek.2
 for <selinux@tycho.nsa.gov>; Sun, 18 May 2014 03:41:05 -0700 (PDT)
Sender: Sven Vermeulen <sven.j.vermeulen@gmail.com>
Date: Sun, 18 May 2014 12:40:48 +0200
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: =?utf-8?B?dG9hzIluIGN1zIA=?= <xuantoanbkfet@gmail.com>
Subject: Re: create new roles for user
Message-ID: <20140518104048.GA21381@siphos.be>
References: <CANh19KAN9O-S8VfGYjp8ObGLFsGtSJNXDtwyVvBrYp3U0zPaUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CANh19KAN9O-S8VfGYjp8ObGLFsGtSJNXDtwyVvBrYp3U0zPaUw@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, May 17, 2014 at 04:26:09PM +0700, toản cù wrote:
>    Hi all!Â
>    I just researching policy in selinux, and I am facing an issue when
>    create new roles for user. I want to add roles for user.Â Â look
>    forward your help!

Hi Toản,

SELinux roles are defined through the SELinux policy, so in order to create
new roles, you need to create a SELinux policy module that contains the
proper statements.

With the reference policy, creating roles is not that hard. All that is
needed is a policy like the following (example for a postgresql
administration role):

#v+
policy_module(mypgsqladm, 1.0)

userdom_login_user_template(pgsqladm)

optional_policy(`
	postgresql_admin(pgsqladm_t, pgsqladm_r)
')
#v-

The call to userdom_login_user_template() creates a role (pgsqladm_r in the
example) and user domain (pgsqladm_t in the example) that can be used as
prilary login type (hence the "login" in the template call).

There are other templates available as well, such as
userdom_base_user_template() for the "basic" role definitions,
userdom_unpriv_user_template() and userdom_admin_user_template() for
unprivileged and privileged roles, etc.

Once this policy module is built and loaded, you can use the generated user
domains and roles. You will need to update files in /etc/selinux/*/contexts,
such as
- default_type (where pgsqladm_r:pgsqladm_t needs to be added)
- default_contexts (where the pgsqladm_r related target types will need to
  be added)

With these changes in place, just assign the role(s) to the users and you're
ready to go.

Wkr,
	Sven Vermeulen
