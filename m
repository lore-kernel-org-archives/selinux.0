Subject: Re: Fwd: adding a new security class
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40804170600g610fb3fdy2f7f416d4d7849ff@mail.gmail.com>
References: <cadfc0e40804161540u2c8796dcr99f67dc7c1aba33d@mail.gmail.com>
	 <48073FC6.6040908@redhat.com>
	 <cadfc0e40804170600g610fb3fdy2f7f416d4d7849ff@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 17 Apr 2008 09:14:40 -0400
Message-Id: <1208438080.18883.361.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-04-17 at 08:00 -0500, Xavier Toth wrote:
> ---------- Forwarded message ----------
> From: Daniel J Walsh <dwalsh@redhat.com>
> Date: Thu, Apr 17, 2008 at 7:17 AM
> Subject: Re: adding a new security class
> To: Xavier Toth <txtoth@gmail.com>
> Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>
> 
> 
> -----BEGIN PGP SIGNED MESSAGE-----
>  Hash: SHA1
> 
> 
> 
>  Xavier Toth wrote:
>  > I'm trying to add a new security class for x copy/paste but I'm not
>  > sure if I doing it right. I patched some headers in libselinux but
>  > then I noticed the "Do not edit..." how are they generated, it doesn't
>  > happen when I build from the source rpm? At this point I'm a bit
>  > confused about how the connection is made between the policy class
>  > definition and libselinux.
>  >
>  > Ted
>  You need to add the code to selinux-policy/module/flask directory and
>  then use the Makefile to generate these files.
> 
>  You should ask questions like this on the list, so others would learn,
>  and more knowledgeable people can answer.  :^)

James captured my response to a prior instance of this question on the
selinuxproject wiki:
http://selinuxproject.org/page/Adding_New_Permissions

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
