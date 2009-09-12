Subject: Re: [git bisected] 25354c4fee169710fd9da15f3bb2abaa24dcf933 is
 first  bad commit
From: Eric Paris <eparis@redhat.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, tresys <refpolicy@oss1.tresys.com>,
        James Morris <jmorris@namei.org>, Serge Hallyn <serue@us.ibm.com>,
        dwalsh@redhat.com, sds@tycho.nsa.gov
In-Reply-To: <dd18b0c30909121606t3a2cbe2bw268659ca04fd6737@mail.gmail.com>
References: <dd18b0c30909121509j154e56e2h860266c53082cc2c@mail.gmail.com>
	 <1252794521.13780.16.camel@dhcp231-106.rdu.redhat.com>
	 <dd18b0c30909121606t3a2cbe2bw268659ca04fd6737@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Sep 2009 19:10:03 -0400
Message-Id: <1252797003.13780.22.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2009-09-12 at 16:06 -0700, Justin Mattock wrote:
> On Sat, Sep 12, 2009 at 3:28 PM, Eric Paris <eparis@redhat.com> wrote:
> > On Sat, 2009-09-12 at 15:09 -0700, Justin Mattock wrote:
> >> attached is dmesg of the latest
> >> Head giving me an avc denial that
> >> is giving me an error with checkpolicy:
> >>
> >> /usr/bin/checkpolicy -c 22  -U deny policy.conf -o policy.22
> >> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> >> policy/modules/services/xserver.te":1138:ERROR 'permission
> >> module_request is not defined for class system' at token ';' on line
> >> 2904222:
> >> allow NetworkManager_t kernel_t:system module_request;
> >> #============= NetworkManager_t ==============
> >> policy/modules/services/xserver.te":1141:ERROR 'permission
> >> module_request is not defined for class system' at token ';' on line
> >> 2904225:
> >> #============= insmod_t ==============
> >> allow insmod_t kernel_t:system module_request;
> >> policy/modules/services/xserver.te":1144:ERROR 'permission
> >> module_request is not defined for class system' at token ';' on line
> >
> > It's because you are using the -U deny.  You are telling the kernel to
> > deny unknown permissions and then you are trying to define an unknown
> > permission.  There is nothing wrong with the kernel.
> >
> > I do need to submit the policy path to define it, but that's not a good
> > idea until we know more or all of the places it is needed.  I hoped to
> > work on that with dwalsh in rawhide before we push the policy patch
> > upstream.  You can help there!  In your base policy module you need to
> > define 'request_module' in the system class in
> > policy/flash/access_vectors rebuild and load the base policy policy
> > module.  Then you can use the request_module permission.
> >
> > -Eric
> >
> >
> 
> Cool,
> I can try and see if I can create
> a class for the policy(good learning here)
> but just keep in mind, don't wait up for me,
> for it could take a while.
> 
> Anyways I went in and commented out the
> unknown permissions option in build.conf(then
> make clean make conf etc..) and
> it seems to keep triggering this error.
> 
> From what it seems, maybe I have something
> wrong with my userspace tools.
> (ill update tomorrow, and see if it compiles
> through).

Ah no, sorry, I wasn't clear.  The -U dney is what causes the kernel to
audit the denial.  Without that the kernel won't complain and will work
just fine without those rules.  With the deny you are going to have to
add the one line to the file I indicated and include those rules.

Thanks
-Eric



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
