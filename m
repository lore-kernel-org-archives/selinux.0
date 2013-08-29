Message-ID: <521F43B4.5040303@tycho.nsa.gov>
Date: Thu, 29 Aug 2013 08:51:00 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Daniel P. Berrange" <berrange@redhat.com>
CC: Colin Walters <walters@verbum.org>, SELinux List <selinux@tycho.nsa.gov>,
        dwalsh@redhat.com, eparis@redhat.com
Subject: Re: libselinux's __attribute__((constructor)) versus nVidia libGL.so
References: <1377625212.20072.4.camel@localhost> <1377625674.20072.5.camel@localhost> <20130828100612.GI15706@redhat.com>
In-Reply-To: <20130828100612.GI15706@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/28/2013 06:06 AM, Daniel P. Berrange wrote:
> On Tue, Aug 27, 2013 at 01:47:54PM -0400, Colin Walters wrote:
>> This bug:
>>
>> https://bugzilla.gnome.org/show_bug.cgi?id=706836
> 
> FWIW, you can define "priority" values on the constructor attributes, to
> sort out ordering between libraries, but this sucks as a general purpose
> solution as it requires co-ordination of priorities between different a
> projects. eg you might fix the selinux vs nvidia problem now, but it can
> recur with any other library using constructors in the future. IMHO it
> would be better to use pthread_once to do any one time initialization
> of library code

I think we considered switching that constructor over to using
pthread_once (as we already do for many other forms of initialization
via the selinux_once macro), but it would require inserting such calls
into many/most of the libselinux functions prior to any use of
selinux_mnt or selinux_page_size.  Certainly doable (and willing to
accept such a patch), but I guess the question is whether it is worth it
or if nvidia should just fix their library.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
