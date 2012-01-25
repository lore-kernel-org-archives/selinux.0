Subject: Re: SEAndroid Build for Galaxy Nexus
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Bryan Hinton <bryan@bryanhinton.com>, SELinux@tycho.nsa.gov
In-Reply-To: <4F201954.8080004@manicmethod.com>
References: 
	 <CA+XzHePWuxzjF8RjxXzEGd0c8tK5bgW2rEeNC6dkSJ4-jNSOLA@mail.gmail.com>
	 <1327495215.9607.2.camel@moss-pluto>  <4F201954.8080004@manicmethod.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 Jan 2012 15:46:59 -0500
Message-ID: <1327524419.13448.1.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-01-25 at 10:01 -0500, Joshua Brindle wrote:
> I also have it running on the Galaxy Nexus. One thing I had to do was /factory 
> was unlabeled after the initial boot. The files in there are all owned by radio 
> so I labeled them u:r:radio_device:s0. Since the default policy only allows 
> chr_file access for radio_device I had to add regular files and directory access 
> to the policy. I'll send up a patch when I've gotten other issues resolved.

I wouldn't overload the radio_device type in that manner.  There is
already radio_data_file if you want the radio/phone app to be able to
access it, or create a new type if you only want rild to access it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
