Subject: Re: I would like to change the behavior of MCS label creations in
 directory.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Windsor <dwindsor@gmail.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh
 <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <CAEXv5_h=OxxNUnzFOihpjKSCrQ492N9s_UmwdujFneQ1zk2g4g@mail.gmail.com>
References: <4E7B9233.6080609@redhat.com>
	 <1316723465.2354.6.camel@moss-pluto> <4E7B9B43.9000400@redhat.com>
	 <1316723821.2354.9.camel@moss-pluto> <1316724121.2354.12.camel@moss-pluto>
	 <4E7C9F3D.9030704@redhat.com> <1316790421.10259.70.camel@moss-pluto>
	 <CAEXv5_hX_dG8+YeJPOdxZafxV2Nf2dM=CKpstUf+vzdYaw2TLw@mail.gmail.com>
	 <1317139611.22218.9.camel@moss-pluto> <4E82123C.4070406@redhat.com>
	 <4E985BFB.1000806@redhat.com> <4E9D7267.9060004@tresys.com>
	 <00243337-937e-4e6b-880b-ba2f351112e7@email.android.com>
	 <CAEXv5_h=OxxNUnzFOihpjKSCrQ492N9s_UmwdujFneQ1zk2g4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 19 Oct 2011 12:55:01 -0400
Message-ID: <1319043301.7667.11.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-10-18 at 18:07 -0400, David Windsor wrote:
> My client truncated my earlier message.
> 
> Is per-object granularity sufficient, or would a tuple of
> (user/role/type, object) be a better key for indexing these rules?
> This makes sense for the role and type fields of a context, but I'm
> not so sure about the user field.
> 
> Examples:
> 
> default_user NetworkManager_t dir_file_class process;
> default_role NetworkManager_t dir_file_class process;
> default_type NetworkManager_t dir_file_class process;
> 
> I'm just unsure that per-object granularity is sufficient.  Thoughts?

We're trying to introduce the ability to configure the fallback default
for labeling behavior when no *_transition rule matches.
Per-object-class should be sufficient for that purpose.  If we want to
introduce more general _transition rules we can do that separately.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
