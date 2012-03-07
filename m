Subject: Re: SEAndroid make_ext4fs fails with new changes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Subramani Venkatesh <selinuxv31@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <CAD8iFzy_fpPEwoJ0q8563NjhuisQ1uz5GebtYojhsysZdoHfpQ@mail.gmail.com>
References: 
	 <CAD8iFzxwJSwJ+LGzByLN9sskyy5UiW-6zGWNOmJ0Fu6X1_EsbQ@mail.gmail.com>
	 <1331138112.16697.54.camel@moss-pluto>
	 <CAD8iFzy_fpPEwoJ0q8563NjhuisQ1uz5GebtYojhsysZdoHfpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Mar 2012 13:12:10 -0500
Message-ID: <1331143930.16697.59.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-03-07 at 11:55 -0500, Subramani Venkatesh wrote:
> Hi Stephen,
> I created 2 files sepolicy.fc and sepolicy.te in
> device/samsung/<TARGET_BOARD>/, there was one error in sepolicy.fc
> file, I fixed it, but then when I rebuild the changes are not taking
> affect, it shows error file. Probably I have to delete
> obj/ETC/sepolicy_intermediates and rebuild it.

Hmm...I couldn't seem to reproduce.  What exactly did you have in your
sepolicy.fc file originally, and how did you "fix" it?  Did the fixed
version have a newer timestamp than the broken one?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
