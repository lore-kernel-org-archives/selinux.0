MIME-Version: 1.0
In-Reply-To: <AANLkTinus_5iaHauJOPUmiMjqGYtPj+r=RFYjsWTiz5C@mail.gmail.com>
References: <AANLkTinus_5iaHauJOPUmiMjqGYtPj+r=RFYjsWTiz5C@mail.gmail.com>
Date: Mon, 11 Apr 2011 15:40:06 -0400
Message-ID: <BANLkTinRKbLTt6nVi8YtUNj-SYB6_5jxKA@mail.gmail.com>
Subject: Re: Named TYPE_TRANSITION and userspace AVC
From: Eric Paris <eparis@parisplace.org>
To: Kohei KaiGai <kaigai@kaigai.gr.jp>
Cc: Eric Paris <eparis@redhat.com>, SELinux-ML <selinux@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Apr 3, 2011 at 7:35 AM, Kohei KaiGai <kaigai@kaigai.gr.jp> wrote:
> We may have a possible issue regarding to the named TYPE_TRANSITION
> feature and userspace avc.

> The question is whether avc_compute_create() should support named
> TYPE_TRANSITION rules, or not.
> In my opinion, userspace object manager should use the new
> security_compute_create_name() instead, when it tries to obtain the
> security context to be assigned on a new named object.

That's the approach the kernel takes.  We don't attempt to cache
TYPE_TRANSITION rules with a name component.  At least in the
workflows in kernel it didn't seem that it would be common for the
results to be reused with any regularity.  How often are you going to
create a file called hda1 in a directory labeled device_t?  After
seeing how many rules Dan is hoping to load i am making some changes
to how I store and find such rules to make it faster, but I'm still
not going to cache them in the AVC.  Doing so is only useful if I
expect to ever reference the same rule twice.  And I don't.

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
