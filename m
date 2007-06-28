Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5SEL3DS006104
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2007 10:21:04 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5SEL2aM027190
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2007 14:21:02 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l5SEL2Qe022180
	for <selinux@tycho.nsa.gov>; Thu, 28 Jun 2007 10:21:02 -0400
Subject: Re: [PATCH] Initial policyrep patch
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: James Antill <jantill@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1182805129.4391.41.camel@code.and.org>
References: <d060fb6e9bd19573be1a.1182796135@localhost.localdomain>
	 <1182805129.4391.41.camel@code.and.org>
Content-Type: text/plain
Date: Thu, 28 Jun 2007 10:20:59 -0400
Message-Id: <1183040459.3091.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-06-25 at 16:58 -0400, James Antill wrote:
> On Mon, 2007-06-25 at 14:28 -0400, Karl MacMillan wrote:
> > Initial patch to create a new policyrep branch using C++. This patch includes basic classes for
> > representing policy (Node and Parent), a few policy objects, a bison parser, a boost::python
> > binding, and basic test infrastructure.
> > 
> > Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
> 
>  So I suck at C++, so feel free to ignore any of these comments that are
> stupid :)
> 

That's ok - I'm desperately trying to remember C++.

> > +namespace policyrep {
> > +
> > +	class location;
> > +
> > +	class Parser {
> > +	public:
> > +		Parser();
> > +		virtual ~Parser();
> > +
> > +		// scanner
> > +		void scan_begin();
> > +		void scan_end();
> > +		bool trace_scanning;
> > +
> > +		// Parser
> > +		Module* parse(const std::string& f);
> 
>  Why are you returning a pointer here, this implies that it can return
> NULL ... but it can't, it throws an exception if there's an error.
> 

I actually changed this to return a shared_ptr<Module> to match the rest
of the code.

> > +		std::string file;
> 
>  Do you really want public members like this?
> 

Made this use the PIMPL pattern.

> > +		bool trace_parsing;
> > +		Module* pmodule;
> > +
> > +		// error handling
> > +		virtual void error(const policyrep::location& l, const std::string& m);
> > +		virtual void error(const std::string& m);
> > +	};
> [...]
> > +	struct PolicyImpl;
> > +	class Policy : public Parent {
> > +	public:
> > +		Policy(bool mls=false);
> > +		Policy(const Policy& other);
> > +		virtual ~Policy() { };
> > +		void operator=(const Policy& other);
> 
>  Is it normal to have only a virtual dtor? My understanding was you
> generally wanted ctor, dtor and op= to have the same overidability.
> 

Constructors can't be virtual, but I made op= virtual and a few others.

> > +		bool get_mls() const;
> > +		void set_mls(bool val);
> 
>  Isn't this better done with polymorphism? Like:
> 

You mean overloading.

>                  bool mls() const;
>                  void mls(bool);
> 

Matter of taste - I prefer the explicit get/set as it makes wrapping the
code in non-C++ languages easier. If people have a strong preference we
can change this.

> > +                virtual void output(std::ostream& o, enum OutputStyle style=DEFAULT_OUTPUT) const;
> > +	protected:
> > +		PolicyImpl* impl;
> > +	};
> > +	typedef boost::shared_ptr<Policy> PolicyPtr;
> 
> [...]             
> > +                std::string get_name() const;
> > +                void set_name(std::string name);
> > +                std::string get_version() const;
> > +                void set_version(std::string version);
> 
>  Don't you want to be returning a const reference like:
> 
>                   const std::string &name(void) const;
> 
> ...AIUI this automatically converts to a std::string via. copy in the
> cases you need a writable version. Dito. the set version, but just for
> the speed increase (Ie. the internal member is still a plain
> std::string).
> 

I had been intentionally returning std::string and letting the copies
happen to make ownership obvious (again, this helps with wrapping the
code for other languages).

However, on reconsidering I made them const references and changed
boost::python to do the copying.

> > +       Module::Module() : impl(new ModuleImpl) { }
> > +
> > +       Module::Module(const Module& other)
> > +               : Parent(), impl(new ModuleImpl)
> > +       {
> > +               *impl = *other.impl;
> > +       } 
> 
>  So you are allocating memory to a pointer impl, but the Policy dtor
> does nothing?
> 

Oops.

> > +                virtual void output(std::ostream& o, enum OutputStyle style=DEFAULT_OUTPUT) const;
> > +        protected:
> > +		ModuleImpl* impl;
> > +        };
> > +	typedef boost::shared_ptr<Module> ModulePtr;
> [...]
> 
> > +	void Policy::operator=(const Policy& other)
> > +	{
> > +		*impl = *impl;	
> > +	}
> 
>  This looks very wrong.
> 

Maybe :)

New patch coming.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
